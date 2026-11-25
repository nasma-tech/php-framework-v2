$(function () {
    let makeData = [];
    let makeLabels = [];
    let makeDates = [];

    $(".editTotalPriceChart").each(function (index) {
        let date = $(this).data('date');
        let price = parseFloat($(this).val());
        if (!isNaN(price)) {
            makeData.push(price);
            makeLabels.push(
                date
            );
            makeDates.push(date);
        }
    });

    const options = {
        series: [
            {
                name: 'مبلغ پیش‌فاکتور',
                data: makeData
            }
        ],

        chart: {
            height: 350,
            type: 'area',
            toolbar: {
                show: false
            },
            fontFamily: 'primary-font, sans-serif'
        },

        dataLabels: {
            enabled: false
        },

        stroke: {
            curve: 'smooth',
            width: 3
        },

        fill: {
            type: 'gradient',
            gradient: {
                opacityFrom: 0.4,
                opacityTo: 0.05
            }
        },

        markers: {
            size: 5,
            hover: {
                size: 7
            }
        },

        xaxis: {
            type: 'category',
            categories: makeLabels,
            title: {
                text: 'تاریخچه ویرایش پیش‌فاکتور'
            }
        },

        yaxis: {
            labels: {
                formatter: function (val) {
                    return val.toLocaleString('fa-IR');
                }
            }
        },

        tooltip: {
            custom: function ({series, seriesIndex, dataPointIndex}) {

                let price = series[seriesIndex][dataPointIndex];
                let label = makeLabels[dataPointIndex];
                let date = makeDates[dataPointIndex];

                return `
                <div class="px-3 py-2">
                    <div class="fw-bold mb-1">${label}</div>
                    <div>تاریخ: ${date || '-'}</div>
                    <div>
                        مبلغ:
                        <strong>${Number(price).toLocaleString('fa-IR')} تومان</strong>
                    </div>
                </div>
            `;
            }
        },

        noData: {
            text: 'اطلاعاتی برای نمایش وجود ندارد'
        }
    };

    new ApexCharts(
        document.querySelector("#proformaRevisionChart"),
        options
    ).render();


})