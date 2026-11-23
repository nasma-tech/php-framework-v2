{include 'sections/header.tpl'}
{include 'sections/top-bar.tpl'}
{include 'sections/side-menu.tpl'}

<div class="app-content content">
    <div class="content-wrapper">
        <div class="container">
            {$flashMessageHelper->formCallBack()}
            <div class="row">
                <div class="col-md-12">
                    <div class="card shadow">
                        <div class="card-header">
                            <h4 class="card-title" style="float: right">افزودن واریزی جدید</h4>
                            {$buttonHelper->refreshAndBackButton()}
                            <a class="badge badge-success text-white" id="addPaymentRow"
                               style="float: left;cursor: pointer;">افزودن واریزی</a>
                        </div>
                    </div>
                </div>
            </div>
            <form action="/PaymentManagement/add" id="mainForm" method="post" enctype="multipart/form-data">
                {$csrf->csrfTokenInput()}
                <div class="row" id="mainRowPayment"></div>
            </form>
        </div>
    </div>
</div>


{include 'sections/footer.tpl'}