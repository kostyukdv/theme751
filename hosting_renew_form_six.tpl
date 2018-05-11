{if ($currentcycle || $unpaidinvoice) && !$cancelrequest}
    {literal}
        <script type="text/javascript">
            function sendform(selected, cycle){
                var form = $(selected).closest("form");
                $('#change_billing').val(cycle);
                $(form).submit();
            }
        </script>
        <style>
            ul.dropdown-menu li a:hover {
                cursor: pointer!important;
            }
        </style>
    {/literal}

    <div id="mg_area" style="width: 100%; text-align: center;"> 
        <label>
            <h4>{$HR_lang.autorenewal_label}: {if $autorenewal == 'off'}<span class="label label-warning">OFF</span>{else}<span class="label label-success">ON</span>{/if}</h4>
        </label>
        <div class="col-md-12">
            <div style="display: inline-block; margin-top: 70px; margin-bottom: 20px; float:left;">
                {if $upfront_control == 1}
                    <form style="margin-bottom: 5px; display: inline-flex;" id="uppay" action="index.php?m=hosting_renewals&id={$id}" method="post">
                        <span>
                            <input name="upfrontpayment" type="hidden" value="1" />
                            <input type="hidden" name="cycle" value="{$rawcurrentcycle}" />
                            <button style="width: 100% !important" class="btn btn-primary">{$HR_lang.renewfor} {$HR_lang.$currentcycle}</button>
                        </span>
                    </form>
                {/if}
                {if $autorenew_control == 1}
                    <form style="margin: 0 10px 5px 10px; display: inline-flex;" id="uppay" action="clientarea.php?action=productdetails&id={$id}" method="post">
                        <div>
                            <input type="hidden" name="turn_autorenewal" value="{if $autorenewal == 'off'}on{else}off{/if}" />
                            <button style="width: 100% !important" id="autorenewal" {if $autorenewal == 'off'} class="btn btn-success" {else} class="btn btn-danger" {/if} >{if $autorenewal == 'off'}{$HR_lang.turnautorenewoff}{else}{$HR_lang.turnautorenewon}{/if}</button>
                        </div>
                    </form>
                {/if}
                {if $billing_cycle_control == 1 && $biling_cycles}
                    <form style="display: inline-flex;" id="billing_cycle_uppay" action="clientarea.php?action=productdetails&id={$id}" method="post">     
                        <input type="hidden" value="" id="change_billing" name="change_billing_cycle">
                        <div class="dropdown">
                            <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">{$HR_lang.choose_biling_cycle}
                            <span class="caret"></span></button>
                            <ul class="dropdown-menu">
                                {foreach from=$biling_cycles key=cycle item=name}
                                    <li role="presentation">
                                        <a role="menuitem" onclick="sendform(this, '{$cycle}');">
                                            {if $hostingRenewalsPriceFormat == '2'}
                                                {$name.name} - {$hrCurrencyPrefix}{$name.price}{$hrCurrencySuffix} {if $name.diverence|strpos:"-" === 0}<span style="color: #46A546;">(-{$hrCurrencyPrefix}{$name.diverence|substr:1}{else}<span style="color: #F00;">(+{$hrCurrencyPrefix}{$name.diverence}{/if}{$hrCurrencySuffix})</span>                                            
                                            {else if $hostingRenewalsPriceFormat == '3'}
                                                {$name.name} - {$hrCurrencyPrefix}{$name.price}{$hrCurrencySuffix} {if $name.diverence|strpos:"-" === 0}<span style="color: #46A546;">({else}<span style="color: #F00;">(+{/if}{$name.diverencePercentage}%)</span>                                             
                                            {else if $hostingRenewalsPriceFormat == '4'}
                                                {$name.name} - {$hrCurrencyPrefix}{$name.price}{$hrCurrencySuffix} 
                                            {else}
                                                {$hrCurrencyPrefix}{$name.price}{$hrCurrencySuffix} {$name.name} {if $name.diverence|strpos:"-" === 0}<span style="color: #46A546;">-{$hrCurrencyPrefix}{$name.diverence|substr:1}{else}<span style="color: #F00;">+{$hrCurrencyPrefix}{$name.diverence}{/if}{$hrCurrencySuffix} ({$name.diverencePercentage}%)</span>
                                            {/if}
                                        </a>
                                    </li>
                                {/foreach}
                            </ul>
                        </div>        
                    </form> 
                {/if}
            </div>
        </div>
        {if $er_comunicat}<div style="color:#F00;font-weight:bold;">{$er_comunicat}</div>{/if}        
        {if $success}<div style="color:#46A546;font-weight:bold;">{$success}</div>{/if}
    </div>
{/if}
