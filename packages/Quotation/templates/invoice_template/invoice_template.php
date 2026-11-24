<?php
$escape = $escape ?? [];
$quote = $quote ?? [];
?>

<!doctype html>
<html lang="fa-IR">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= $quote['title'] ?> <?= $quote['number'] ?></title>
</head>

<body>
<div class="container w-100 p-0 quotation-container">

    <!-- Requester Details -->
    <div class="quotation-header">
        <div class="quotation-header-spacer">
            <img src="<?= $quote['logo_path'] ?>" alt="">
        </div>

        <div class="quotation-header-title">
            <h3 class="text-center"><?= $quote['title'] ?></h3>
        </div>

        <div class="quotation-header-info">
            <h6>
                شماره : <span><?= $escape($quote['number'] ?? '') ?></span>
            </h6>

            <h6>
                تاریخ : <span><?= $escape($quote['date'] ?? '') ?></span>
            </h6>
        </div>
    </div>

    <table class="invoice-table quotation-customer-table">
        <tr>
            <th class="quotation-table-heading" colspan="4">مشخصات پیشنهاد دهنده</th>
        </tr>
        <tr>
            <td>پیشنهاد دهنده:</td>
            <td><?= $escape($quote['seller']['name'] ?? '') ?></td>

            <td>شناسه / کد ملی:</td>
            <td><?= $escape($quote['seller']['national_code'] ?? '') ?></td>
        </tr>

        <tr>
            <td>شماره تماس:</td>
            <td><?= $escape($quote['seller']['phone'] ?? '') ?></td>

            <td>کد پستی:</td>
            <td><?= $escape($quote['seller']['postal_code'] ?? '') ?></td>
        </tr>

        <tr>
            <td>نشانی:</td>
            <td colspan="3">
                <?= $escape($quote['seller']['address'] ?? '') ?>
            </td>
        </tr>
    </table>

    <table class="invoice-table quotation-customer-table">
        <tr>
            <th class="quotation-table-heading" colspan="4">مشخصات خریدار</th>
        </tr>
        <tr>
            <td>خریدار محترم:</td>
            <td><?= $escape($quote['customer']['name'] ?? '') ?></td>

            <td>شناسه / کد ملی:</td>
            <td><?= $escape($quote['customer']['national_code'] ?? '') ?></td>
        </tr>

        <tr>
            <td>شماره تماس:</td>
            <td><?= $escape($quote['customer']['phone'] ?? '') ?></td>

            <td>کد پستی:</td>
            <td><?= $escape($quote['customer']['postal_code'] ?? '') ?></td>
        </tr>

        <tr>
            <td>نشانی:</td>
            <td colspan="3">
                <?= $escape($quote['customer']['address'] ?? '') ?>
            </td>
        </tr>
    </table>

    <!-- Invoice Items -->
    <div class="d-flex flex-column mt-3">
        <table class="invoice-table mb-0 borderGray quotation-items-table">
            <thead>
            <tr>
                <td class="quotation-table-heading"><b>ردیف</b></td>
                <td class="quotation-table-heading"><b>شرح کالا</b></td>
                <td class="quotation-table-heading"><b>مقدار</b></td>
                <td class="quotation-table-heading"><b>واحد</b></td>
                <td class="quotation-table-heading"><b>مبلغ واحد (ریال)</b></td>
                <td class="quotation-table-heading"><b>مبلغ کل (ریال)</b></td>
            </tr>
            </thead>

            <tbody>
            <?php foreach (($quote['items'] ?? []) as $index => $item): ?>
                <tr>
                    <td class="text-center">
                        <?= $index + 1 ?>
                    </td>

                    <td>
                        <?= $escape($item['description'] ?? '') ?>
                    </td>

                    <td class="text-center">
                        <?= $escape(numberNormalizer->floatNumberFormat($item['quantity']) ?? '') ?>
                    </td>

                    <td>
                        <?= $escape($item['unit'] ?? '') ?>
                    </td>

                    <td>
                        <?= number_format($item['unit_price'] ?? 0) ?>
                    </td>

                    <td>
                        <?= number_format($item['total'] ?? 0) ?>
                    </td>
                </tr>
            <?php endforeach; ?>
            <?php foreach ($quote['deductions'] as $deduction): ?>
                <tr>
                    <td colspan="5" class="text-left">
                        <?= $deduction['precent'] ?>% <?= $deduction['description'] ?>
                    </td>

                    <td>
                        <?= number_format($deduction['total']) ?>
                    </td>
                </tr>
            <?php endforeach; ?>
            <tr>
                <td colspan="5" class="text-left">
                    جمع کل
                </td>

                <td>
                    <?= number_format($quote['total'] ?? 0) ?>
                </td>
            </tr>
            <tr>
                <td colspan="3" class="text-center">
                    شرایط و نحوه تسویه: نقدی
                    <input type="checkbox">
                    غیر نقدی
                    <input type="checkbox">
                </td>
                <td colspan="3" class="text-left">
                    <?= numberToWord->numberToWords($quote['total']) ?> ریال
                </td>
            </tr>
            </tbody>
        </table>
    </div>

    <div>
        <div class="quotation-conditions">
            <?php if ($quote['payment_term']): ?>
                <h4 class="pr-2">شرایط پرداخت</h4>
                <div class="mr-1">
                    <?= $quote['payment_term'] ?>
                </div>
            <?php endif; ?>

            <?php if ($quote['bottom_invoice_text']): ?>
                <h4 class="pr-2">توضیحات پیش فاکتور</h4>
                <div class="mr-1">
                    <?= $quote['bottom_invoice_text'] ?>
                </div>
            <?php endif; ?>
            <ul>
                <?php foreach (($quote['conditions'] ?? []) as $condition): ?>
                    <li>
                        <span><?= $escape($condition) ?></span>
                    </li>
                <?php endforeach; ?>
            </ul>
        </div>

        <!-- Signature Area -->
        <div class="d-flex align-items-center justify-content-center text-center mt-2 lh-1 quotation-signature">

            <div class="quotation-signature-column">
                <div class="mb-3">
                    <span class="quotation-signature-label">پیشنهاد دهنده</span>
                </div>

                <div>
                    <span><?= $escape($quote['applicant_name'] ?? '-') ?></span>
                </div>
            </div>

            <div class="quotation-signature-label">
                <div class="mb-1">متقاضی</div>

                <?php if (!empty($quote['signature_path'])): ?>
                    <img
                            src="<?= $escape($quote['signature_path']) ?>"
                            alt="signature"
                            width="150"
                    >
                <?php endif; ?>
            </div>

        </div>
    </div>

</div>
</body>
</html>
