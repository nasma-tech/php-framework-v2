<?php

namespace Packages\Helpers;

use App\Models\YearModel\YearModel;
use DateTime;

class DateTimeHelper
{
    public
    function convertTimeToMinute(string $time = '00:00', string $separator = ':'): float|int
    {
        $result = 0;
        $explodeTime = explode($separator, $time);

        if (count($explodeTime) > 1) {
            $result += ((intval($explodeTime[0]) * 60) + (((str_contains($explodeTime[0], '-')) ? -1 : 1) * intval($explodeTime[1])));
        }

        return $result;
    }

    public
    function convertMinuteToTime(int $time, string $separator = ':'): string
    {
        $hours = floor(abs($time) / 60);
        $minutes = abs($time) % 60;

        $formattedTime = $this->fixTwoDigitsNumber($hours) . $separator . $this->fixTwoDigitsNumber($minutes);

        return $time < 0 ? '-' . $formattedTime : $formattedTime;
    }

    public
    function getYearIdByTimeStamp(int $timestamp)
    {
        $get = YearModel::query()->where(['year_value' => jdate('Y', $timestamp)])->first();

        if ($get) {
            $result = $get->id();
        }

        return $result ?? 0;
    }

    public
    function getFirstDayOfYear(int $year = null): false|int
    {
        return jmktime(0, 0, 0, '01', '01', (($year) ?: jdate("Y")));
    }

    public
    function getLastDayOfYear(int $year = null): int
    {
        return jmktime(0, 0, 0, '01', '01', ((($year) ?: jdate("Y")) + 1)) - 1;
    }

    public
    function totalDaysOfThisYear($year = null): array|int|string
    {
        if (!$year) {
            return jdate('z') + jdate('Q') + 1;
        }
        return (($year + 1) % 4 == 0) ? 366 : 365;
    }

    public
    function fixTwoDigitsNumber(int $number): string
    {
        return (strlen(strval($number)) == 1) ? '0' . $number : strval($number);
    }

    public
    function getFirstDayOfMonth(int $month = null, int $year = null): false|int
    {
        if (!$month) {
            $month = jdate('m');
        }
        return jmktime(0, 0, 0, ($month <= 12 ? $this->fixTwoDigitsNumber($month) : 1), '01', (($year) ? $year + ($month > 12 ? 1 : 0) : jdate("Y") + ($month > 12 ? 1 : 0)));
    }

    public
    function getLastDayOfMonth(int $month = null, int $year = null, bool $returnExactTime = false): false|int
    {
        if (!$month) {
            $month = jdate('m');
        }
        return jmktime(0, 0, 0, ($month < 12 ? (intval($this->fixTwoDigitsNumber($month)) + 1) : 1), '01', (($year) ? $year + ($month < 12 ? 0 : 1) : jdate("Y") + ($month < 12 ? 0 : 1))) - (($returnExactTime) ? 1 : 86400);
    }

    public
    function calculateBetweenTime(DateTime $firstTime, DateTime $secondTime): string
    {
        $calc = $secondTime->diff($firstTime);
        if ($calc->invert) {
            return $calc->format('%H:%I');
        }
        return "00:00";
    }

    public
    function convertStringTimeToDateTime(string $time = "00:00"): DateTime
    {
        return new DateTime(date("Y-m-d") . " $time");
    }

    public
    function removeTimeInTimeStamp(int $timeStamp): false|int|string
    {
        return $this->convertDateToTimestamp(jdate("Y/m/d", $timeStamp));
    }

    public
    function convertTimeToDay($time, bool $roundOutput = false, float $hoursInDays = 24): float|int
    {
        $isNegative = false;
        if (str_starts_with($time, '-')) {
            $isNegative = true;
            $time = ltrim($time, '-');
        }

        if (!preg_match('/^\d{1,3}:\d{2}$/', $time)) {
            return 0;
        }

        $explodeTime = explode(':', $time);

        if (count($explodeTime) === 2) {
            $hours = intval($explodeTime[0]);
            $minutes = intval($explodeTime[1]);

            if ($minutes < 0 || $minutes >= 60) {
                return 0;
            }

            $totalHours = $hours + ($minutes / 60);

            if ($isNegative) {
                $totalHours *= -1;
            }

            $calculate = $totalHours / $hoursInDays;

            if ($roundOutput) {
                $calculate = round($calculate, 2);
            }

            return $calculate;
        }

        return 0;
    }

    public
    function calculateCountDaysBetweenTimeStamps($firstTimeStamp, $secondTimeStamp): int
    {
        return (($this->removeTimeInTimeStamp($secondTimeStamp) - $this->removeTimeInTimeStamp($firstTimeStamp)) / 86400) + 1;
    }

    public
    function checkTimeRangeOverlap(array $searchInterval = ["00:00", "00:00"], array $comparisonInterval = ["00:00", "00:00"]): bool
    {
        if (count($searchInterval) !== 2 || count($comparisonInterval) !== 2) {
            return false;
        }

        $s1 = DateTime::createFromFormat('H:i', $searchInterval[0]);
        $e1 = DateTime::createFromFormat('H:i', $searchInterval[1]);
        $s2 = DateTime::createFromFormat('H:i', $comparisonInterval[0]);
        $e2 = DateTime::createFromFormat('H:i', $comparisonInterval[1]);

        if (!$s1 || !$e1 || !$s2 || !$e2) {
            return false;
        }

        if ($s1 > $e1) {
            [$s1, $e1] = [$e1, $s1];
        }

        if ($s2 > $e2) {
            [$s2, $e2] = [$e2, $s2];
        }

        return $s1 < $e2 && $s2 < $e1;
    }

    public
    function persianMonthNamesWithKey($key): string
    {
        $name = '';
        switch ($key) {
            case '01':
                $name = 'فروردین';
                break;
            case '02':
                $name = 'اردیبهشت';
                break;
            case '03':
                $name = 'خرداد';
                break;
            case '04':
                $name = 'تیر';
                break;
            case '05':
                $name = 'مرداد';
                break;
            case '06':
                $name = 'شهریور';
                break;
            case '07':
                $name = 'مهر';
                break;
            case '08':
                $name = 'آبان';
                break;
            case '09':
                $name = 'آذر';
                break;
            case '10':
                $name = 'دی';
                break;
            case '11':
                $name = 'بهمن';
                break;
            case '12':
                $name = 'اسفند';
                break;
        }
        return $name;
    }

    public
    function checkTimestampRangeOverlap(array $primaryRange = [0, 0], array $secondaryRange = [0, 0], bool $checkStrikMode = false): bool
    {
        if (count($primaryRange) !== 2 || count($secondaryRange) !== 2) {
            return false;
        }

        [$primaryStart, $primaryEnd] = $primaryRange;
        [$secondaryStart, $secondaryEnd] = $secondaryRange;

        if ($primaryStart > $primaryEnd) {
            [$primaryStart, $primaryEnd] = [$primaryEnd, $primaryStart];
        }

        if ($secondaryStart > $secondaryEnd) {
            [$secondaryStart, $secondaryEnd] = [$secondaryEnd, $secondaryStart];
        }

        if ($checkStrikMode) {
            return $primaryStart <= $secondaryEnd && $secondaryStart <= $primaryEnd;
        }
        return $primaryStart < $secondaryEnd && $secondaryStart < $primaryEnd;
    }

    public
    function convertDateToTimestamp(string $date): false|int|string
    {
        if ($date) {
            $explode = explode('/', $date);
            $make = jalali_to_gregorian($explode[0], $explode[1], $explode[2], '/');
            return strtotime($make);
        }
        return $date;
    }

}
