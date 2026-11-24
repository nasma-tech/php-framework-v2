{if $getCargoExitList->count() <= 0}
    <div class="card shadow-sm">
        <div class="card-body bg-warning text-center rounded">
            <i class="bx bx-map-pin text-white font-large-2"></i>
            <h6 class="text-white mb-0 mt-1">اعلام آدرس انجام نشده است</h6>
        </div>
    </div>
{else}
    <div class="card">
        <div class="card-header">
            لیست محصولات

        </div>
        <div class="card-body">
            <div class="col-md-12">

            </div>
        </div>
    </div>
{/if}