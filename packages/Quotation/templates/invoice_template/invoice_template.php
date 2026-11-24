<?php
$escape = $escape ?? [];
?>

<!doctype html>
<html lang="fa-IR">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>پیشنهاد قیمت</title>
</head>

<body>
<div class="container w-100 p-0 quotation-container">

    <!-- Requester Details -->
    <div class="quotation-header">
        <div class="quotation-header-spacer"></div>

        <div class="quotation-header-title">
            <h3 class="text-center">پیشنهاد قیمت</h3>
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
            <td>خریدار محترم :</td>
            <td><?= $escape($quote['customer']['name'] ?? '') ?></td>

            <td>شناسه یا کد ملی :</td>
            <td><?= $escape($quote['customer']['national_code'] ?? '') ?></td>
        </tr>

        <tr>
            <td>شماره تماس :</td>
            <td><?= $escape($quote['customer']['phone'] ?? '') ?></td>

            <td>کد پستی :</td>
            <td><?= $escape($quote['customer']['postal_code'] ?? '') ?></td>
        </tr>

        <tr>
            <td>نشانی :</td>
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
                <td class="quotation-table-heading"><b>مشخصات محصول</b></td>
                <td class="quotation-table-heading"><b>مقدار</b></td>
                <td class="quotation-table-heading"><b>واحد</b></td>
                <td class="quotation-table-heading"><b>قیمت(ریال)</b></td>
                <td class="quotation-table-heading"><b>جمع(ریال)</b></td>
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
                        <?= $escape($item['quantity'] ?? '') ?>
                    </td>

                    <td>
                        <?= $escape($item['unit'] ?? '') ?>
                    </td>

                    <td>
                        <?= $formatMoney($item['unit_price'] ?? 0) ?>
                    </td>

                    <td>
                        <?= $formatMoney($item['total'] ?? 0) ?>
                    </td>
                </tr>
            <?php endforeach; ?>

            <tr>
                <td colspan="5" class="text-left">
                    جمع کل
                </td>

                <td>
                    <?= $formatMoney($quote['total'] ?? 0) ?>
                    <span>ریال</span>
                </td>
            </tr>
            </tbody>
        </table>
    </div>

    <div>
        <div class="quotation-conditions">
            <h4 class="pr-2">توضیحات و شرایط</h4>

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
                    <span class="quotation-signature-label">متقاضی</span>
                </div>

                <div>
                    <span><?= $escape($quote['applicant_name'] ?? '-') ?></span>
                </div>
            </div>

            <div class="quotation-signature-column">
                <div class="mb-3">
                    <?= $escape($quote['salesperson_name'] ?? 'کارشناس فروش') ?>
                </div>

                <table class="quotation-signature-table" dir="rtl">
                    <tr>
                        <td></td>
                        <td class="quotation-signature-image-cell">
                            <?php if (!empty($quote['signature'])): ?>
                                <img
                                        src="<?= $escape($quote['signature']) ?>"
                                        alt="امضا"
                                        width="150"
                                >
                            <?php endif; ?>
                        </td>
                    </tr>
                </table>
            </div>

        </div>
    </div>

</div>
</body>
</html>
