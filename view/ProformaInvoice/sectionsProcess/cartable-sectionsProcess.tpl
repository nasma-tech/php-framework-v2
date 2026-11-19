<div class="row">
    <div class="container">
        {foreach $cartables|default:[] as $cartableType => $cartableData}
            <div class="col-md-12">
                {if $cartableData}
                    {$cartableData->getActivityLogView()}
                {/if}
            </div>
            {foreachelse}
            <div class="col-12 text-center">
                <img src="/public/images/profile/pages/maintenance.png" alt="maintenance" style="max-width: 50%;">
                <h3>هنوز کارتابلی نداریم!</h3>
            </div>
        {/foreach}
    </div>
</div>