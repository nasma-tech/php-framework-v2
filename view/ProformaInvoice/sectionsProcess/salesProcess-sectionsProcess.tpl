<div class="card shadow" style="margin-top: 3px">
    <div class="row">
        <div class="card-body">
            <div class="col-md-12">
                <div class="wizard-vertical">
                    {foreach $stepsConfig as $key => $stepConfig}
                        <h3>
                                                <span class="fonticon-wrap mr-1">
                                                  <i class="bx {$stepConfig['icon']}"></i>
                                                </span>
                            <span class="icon-title">
                                                  <span class="d-block"
                                                        data-stepnumber="{$key + 1}">{$stepConfig['title']}</span>
                                                  <small class="text-muted">{$stepConfig['description']}</small>
                                                </span>
                        </h3>
                        <fieldset class="pt-0">
                            {if isset($stepConfig['conditions'])}
                                {$stepValidation = true}
                                {foreach $stepConfig['conditions'] as $stepCondition}
                                    {if !$stepCondition['condition']}
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="bg-rgba-{$stepCondition['errorLabel']} p-2 text-center rounded">
                                                    <h6>{$stepCondition['errorMessage']}</h6>
                                                </div>

                                            </div>
                                        </div>
                                        {$stepValidation = false}
                                        {break}
                                    {/if}
                                {/foreach}
                                {if $stepValidation}
                                    {include $stepConfig['stepFile']}
                                {/if}
                            {else}
                                {include $stepConfig['stepFile']}
                            {/if}
                        </fieldset>
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
</div>