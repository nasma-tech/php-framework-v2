<?php

namespace Packages\Support\Text;

class PersianTextNormalizer
{
    public
    function persianNumberToEnglish($number): string
    {
        return strtr($number, ['۰' => '0', '۱' => '1', '۲' => '2', '۳' => '3', '۴' => '4', '۵' => '5', '۶' => '6', '۷' => '7', '۸' => '8', '۹' => '9', '٠' => '0', '١' => '1', '٢' => '2', '٣' => '3', '٤' => '4', '٥' => '5', '٦' => '6', '٧' => '7', '٨' => '8', '٩' => '9']);
    }

    public
    function englishNumberToPersian($number): string
    {
        return strtr($number, ['0' => '۰', '1' => '۱', '2' => '۲', '3' => '۳', '4' => '۴', '5' => '۵', '6' => '۶', '7' => '۷', '8' => '۸', '9' => '۹']);
    }

    public
    function removePunctuationMarks(string $value): array|string
    {
        $target = [
            "ً",  // تنوین فتحه
            "ٌ",  // تنوین ضمه
            "ٍ",  // تنوین کسره
            "َ",  // فتحه
            "ُ",  // ضمه
            "ِ",  // کسره
            "ّ",  // تشدید
            "ْ",  // سکون
            "ٰ",  // الف خنجر
            "ـ"   // خط کشیده
        ];
        return str_replace($target, "", $value);
    }

    public
    function fixPersianPunctuationSpacing(string $text): string
    {
        // 0) استاندارد کردن سه‌نقطه
        $text = preg_replace('/\.{3,}/u', '…', $text);

        // --- پرانتز/براکت/گیومه ---
        $brO = '\(\[\{«';
        $brC = '\)\]\}»';

        // حذف فاصله داخل پرانتز/براکت
        $text = preg_replace('/([' . $brO . '])\s+/u', '$1', $text);   // بعد از باز
        $text = preg_replace('/\s+([' . $brC . '])/u', '$1', $text);   // قبل از بسته

        // فاصله بیرونی
        $text = preg_replace('/(\p{L}|\p{Nd})([' . $brO . '])/u', '$1 $2', $text); // قبل از باز
        $text = preg_replace('/([' . $brC . '])(\p{L}|\p{Nd})/u', '$1 $2', $text); // بعد از بسته
        //  + علامت نگارشی: فاصله نداشته باشه
        $text = preg_replace('/([' . $brC . '])\s+([،,؛:!؟…\.])/u', '$1$2', $text);

        // --- ویرگول‌ها ---
        // حذف فاصله قبل از ویرگول فارسی و لاتین
        $text = preg_replace('/\s+،/u', '،', $text);
        $text = preg_replace('/\s+,/u', ',', $text);

        // افزودن فاصله بعد از «،» همیشه (اگر بعدش چیزی است)
        $text = preg_replace('/،(?=\S)/u', '، ', $text);

        // افزودن فاصله بعد از ویرگول لاتین فقط وقتی «بین عدد نیست»
        // یعنی نه قبلش عدد باشد و نه بعدش عدد
        $text = preg_replace('/(?<!\p{Nd}),(?!\p{Nd})(?=\S)/u', ', ', $text);

        // --- دو نقطه / نقطه‌ویرگول / تعجب / سؤال ---
        $text = preg_replace('/\s+([؛:!؟])/u', '$1', $text);          // فاصله قبل حذف
        $text = preg_replace('/([؛:!؟])(?=\S)/u', '$1 ', $text);       // یک فاصله بعد

        // --- نقطه (پایان جمله)، نه اعشار ---
        $text = preg_replace('/\s+\./u', '.', $text);                  // فاصله قبل از نقطه حذف
        // اگر قبل/بعدِ نقطه عدد نیست، و بعدش هم چیزی هست → یک فاصله بگذار
        $text = preg_replace('/(?<!\p{Nd})\.(?!\p{Nd})(?=\S)/u', '. ', $text);
        // فاصله‌های متعدد بعد از نقطهٔ غیر اعشاری را یکی کن
        $text = preg_replace('/(?<!\p{Nd})\.(?!\p{Nd})\s{2,}/u', '. ', $text);

        // --- یکپارچه‌سازی فاصله‌های زیاد بعد از علائم ---
        $text = preg_replace('/([،,؛:!؟…\.])\s{2,}/u', '$1 ', $text);

        // --- تمیزکاری انتهای/ابتدای خطوط ---
        $text = preg_replace('/[ \t]+(\R)/u', '$1', $text);
        $text = preg_replace('/(\R)[ \t]+/u', '$1', $text);

        return trim($this->removePunctuationMarks($text));
    }

    function normalizePersian($text): string
    {
        return strtr($text, [
            'ي' => 'ی',
            'ى' => 'ی',
            'ك' => 'ک',
            'ؤ' => 'و',
            'إ' => 'ا',
            'أ' => 'ا',
            'ٱ' => 'ا',
            'ۀ' => 'ه',
            'ة' => 'ه',
        ]);
    }

    public function fullCheckPersianText($text): string
    {
        return $this->removePunctuationMarks(
            $this->normalizePersian(
                $this->fixPersianPunctuationSpacing(
                    $text
                )
            )
        );
    }
}