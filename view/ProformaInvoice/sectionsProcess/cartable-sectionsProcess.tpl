<div class="row">
    <div class="container">
        {foreach $cartables|default:[] as $cartableType => $cartableData}
            <div class="col-md-12">
                {if $cartableData}
                    {$cartableData->getActivityLogView()}
                {/if}
            </div>
        {/foreach}
    </div>
</div>