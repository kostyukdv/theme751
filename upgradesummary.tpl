{include file="$template/pageheader.tpl" title=$LANG.upgradedowngradepackage}

{if $promoerror}
    {include file="$template/includes/alert.tpl" type="error" msg=$promoerror textcenter=true}
{/if}

{if $promorecurring}
    {include file="$template/includes/alert.tpl" type="info"
    msg=$LANG.recurringpromodesc|sprintf2:$promorecurring textcenter=true}
{/if}

<div class="alert alert-block alert-info">
    {$LANG.upgradecurrentconfig}: <strong>{$groupname} - {$productname}</strong>{if $domain} ({$domain}){/if}
</div>
<table class="table table-striped">
    <thead>
        <tr>
            <th>{$LANG.orderdesc}</th>
            <th>{$LANG.orderprice}</th>
        </tr>
    </thead>
    <tbody>
        {foreach key=num item=upgrade from=$upgrades}
            {if $type eq "package"}
                <tr>
                    <td><input type="hidden" name="pid" value="{$upgrade.newproductid}" /><input type="hidden" name="billingcycle" value="{$upgrade.newproductbillingcycle}" />{$upgrade.oldproductname} => {$upgrade.newproductname}</td>
                    <td class="text-right">{$upgrade.price}</td>
                </tr>
            {elseif $type eq "configoptions"}
                <tr>
                    <td>{$upgrade.configname}: {$upgrade.originalvalue} => {$upgrade.newvalue}</td>
                    <td class="text-right">{$upgrade.price}</td>
                </tr>
            {/if}
        {/foreach}
        <tr class="masspay-total">
            <td class="text-right">{$LANG.ordersubtotal}:</td>
            <td class="text-right">{$subtotal}</td>
        </tr>
        {if $promodesc}
            <tr class="masspay-total">
                <td class="text-right">{$promodesc}:</td>
                <td class="text-right">{$discount}</td>
            </tr>
        {/if}
        {if $taxrate}
            <tr class="masspay-total">
                <td class="text-right">{$taxname} @ {$taxrate}%:</td>
                <td class="text-right">{$tax}</td>
            </tr>
        {/if}
        {if $taxrate2}
            <tr class="masspay-total">
                <td class="text-right">{$taxname2} @ {$taxrate2}%:</td>
                <td class="text-right">{$tax2}</td>
            </tr>
        {/if}
        <tr class="masspay-total">
            <td class="text-right">{$LANG.ordertotalduetoday}:</td>
            <td class="text-right">{$total}</td>
        </tr>
    </tbody>
</table>

{if $type eq "package"}
    {include file="$template/includes/alert.tpl" type="warning" msg=$LANG.upgradeproductlogic|cat:' ('|cat:$upgrade.daysuntilrenewal|cat:' '|cat:$LANG.days|cat:')'}
{/if}

<div class="row px-1">
    <div class="col-md-6 col-md-offset-3">
        <form method="post" action="{$smarty.server.PHP_SELF}" role="form">
            <input type="hidden" name="step" value="2" />
            <input type="hidden" name="type" value="{$type}" />
            <input type="hidden" name="id" value="{$id}" />
            {if $type eq "package"}
                <input type="hidden" name="pid" value="{$upgrades.0.newproductid}" />
                <input type="hidden" name="billingcycle" value="{$upgrades.0.newproductbillingcycle}" />
            {/if}
            <h5>{$LANG.orderpromotioncode}</h5>
            {foreach from=$configoptions key=cid item=value}
                <input type="hidden" name="configoption[{$cid}]" value="{$value}" />
            {/foreach}
            <div class="input-group">
                <input class="form-control" type="text" name="promocode" placeholder="{$LANG.orderpromotioncode}" width="40"
                        {if $promocode}value="{$promocode} - {$promodesc}" disabled="disabled"{/if}>
                {if $promocode}
                    <span class="input-group-btn">
                        <input type="submit" name="removepromo" value="{$LANG.orderdontusepromo}"
                               class="btn btn-danger" />
                    </span>
                {else}
                    <span class="input-group-btn">
                        <input type="submit" value="{$LANG.orderpromovalidatebutton}" class="btn btn-default" />
                    </span>
                {/if}
            </div>
        </form>

        <form method="post" action="{$smarty.server.PHP_SELF}">
            <input type="hidden" name="step" value="3" />
            <input type="hidden" name="type" value="{$type}" />
            <input type="hidden" name="id" value="{$id}" />
            {if $type eq "package"}
                <input type="hidden" name="pid" value="{$upgrades.0.newproductid}" />
                <input type="hidden" name="billingcycle" value="{$upgrades.0.newproductbillingcycle}" />
            {/if}
            {foreach from=$configoptions key=cid item=value}
                <input type="hidden" name="configoption[{$cid}]" value="{$value}" />
            {/foreach}
            {if $promocode}<input type="hidden" name="promocode" value="{$promocode}">{/if}

            <h5>{$LANG.orderpaymentmethod}</h5>
            <div class="form-group">
                <select name="paymentmethod" id="inputPaymentMethod" class="form-control">
                    {if $allowgatewayselection}
                        <option value="none">{$LANG.paymentmethoddefault}</option>
                    {/if}
                    {foreach key=num item=gateway from=$gateways}
                        <option value="{$gateway.sysname}"{if $gateway.sysname eq $selectedgateway} selected="selected"{/if}>{$gateway.name}</option>
                    {/foreach}
                </select>
            </div>
            <div class="form-group"><input type="submit" value="{$LANG.ordercontinuebutton}" class="btn btn-primary btn-lg btn-block" /></div>
          </form>
    </div>
</div>
