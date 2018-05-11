{if ($currentcycle || $unpaidinvoice) && !$cancelrequest}
    {literal}
        <script type="text/javascript">
            jQuery(document).ready(function() {
                $("#change_billing").change(function(e) {
                    var curr_cycle = '{/literal}{$billingcycle}{literal}';
                    var selected_cycle = jQuery(this).find("option:selected").val();
                    var selected_cyclet = jQuery(this).find("option:selected").text();
                    
                    var displayName = jQuery(this).find("option:selected").attr('dname');
                    if(selected_cycle !== '' && confirm("{/literal}{$HR_lang.confirm_text}{literal} " + curr_cycle + " {/literal}{$HR_lang.to}{literal} " + displayName + "?"))
                        $("#billing_cycle_uppay").submit();
                    else
                       jQuery(this).prop('selectedIndex',0);
                });
            });
        </script>
    {/literal}

    <div id="mg_area"> 
        <label>
            <b>{$HR_lang.autorenewal_label}:</b> {if $autorenewal == 'off'}<span class="label pending">OFF</span>{else}<span class="label active">ON</span>{/if}
        </label>
        {if $upfront_control == 1}
        <form style="margin-bottom: 5px; display: inline-flex;" id="uppay" action="index.php?m=hosting_renewals&id={$id}" method="post">
            <span>
                <input name="upfrontpayment" type="hidden" value="1" />
                <input type="hidden" name="cycle" value="{$rawcurrentcycle}" />
                <button style="width: 100% !important" class="btn">{$HR_lang.renewfor} {$HR_lang.$currentcycle}</button>
            </span>
        </form>
        {/if}
        {if $autorenew_control == 1}
        <form style="margin: 0 10px 5px 10px; display: inline-flex;" id="uppay" action="clientarea.php?action=productdetails&id={$id}" method="post">
            <div>
                <input type="hidden" name="turn_autorenewal" value="{if $autorenewal == 'off'}on{else}off{/if}" />
                <button style="width: 100% !important" id="autorenewal"  class="btn" >{if $autorenewal == 'off'}{$HR_lang.turnautorenewoff}{else}{$HR_lang.turnautorenewon}{/if}</button>
            </div>
        </form>
        {/if}
        {if $billing_cycle_control == 1 && $biling_cycles}
        <form style="display: inline-flex;" id="billing_cycle_uppay" action="clientarea.php?action=productdetails&id={$id}" method="post">
            <div>
                <select id="change_billing" name="change_billing_cycle" style="margin-bottom: 0 !important;">
                    <option value="">{$HR_lang.choose_biling_cycle}</option>
                    {foreach from=$biling_cycles key=cycle item=name}
                        <option value="{$cycle}" dname="{$name.name}">
                            {if $hostingRenewalsPriceFormat == '2'}
                                {$name.name} - {$hrCurrencyPrefix}{$name.price}{$hrCurrencySuffix} {if $name.diverence|strpos:"-" === 0}-{$hrCurrencyPrefix}{$name.diverence|substr:1}{else}+{$hrCurrencyPrefix}{$name.diverence}{/if}{$hrCurrencySuffix}
                            {elseif $hostingRenewalsPriceFormat == '3'}
                                {$name.name} - {$hrCurrencyPrefix}{$name.price}{$hrCurrencySuffix} {if $name.diverence|strpos:"-" === 0}({else}(+{/if}{$name.diverencePercentage}%)                                
                            {elseif $hostingRenewalsPriceFormat == '4'}
                                {$name.name} - {$hrCurrencyPrefix}{$name.price}{$hrCurrencySuffix} 
                            {else}
                                {$hrCurrencyPrefix}{$name.price}{$hrCurrencySuffix} {$name.name} {if $name.diverence|strpos:"-" === 0}-{$hrCurrencyPrefix}{$name.diverence|substr:1}{else}+{$hrCurrencyPrefix}{$name.diverence}{/if}{$hrCurrencySuffix} ({$name.diverencePercentage}%)                                
                            {/if}
                        </option>
                    {/foreach}
                </select>
            </div>
        </form>
        {/if}
        {if $error}<div style="color:#F00;font-weight:bold">{$error}</div>{/if}
        {if $success}<div style="color:#46A546;font-weight:bold">{$success}</div>{/if}
    </div>
{/if}