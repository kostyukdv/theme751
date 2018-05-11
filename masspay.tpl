{include file="$template/pageheader.tpl" title=$LANG.masspaytitle desc=$LANG.masspayintro}
<form method="post" action="clientarea.php?action=masspay">
    <input type="hidden" name="geninvoice" value="true" />
    <table class="table table-striped">
        <thead>
            <tr>
                <th>{$LANG.invoicesdescription}</th>
                <th>{$LANG.invoicesamount}</th>
            </tr>
        </thead>
        <tbody>
            {foreach from=$invoiceitems key=invid item=invoiceitem}
            <tr>
                <td colspan="2">
                    <strong>{$LANG.invoicenumber} {$invid}</strong>
                    <input type="hidden" name="invoiceids[]" value="{$invid}" />
                </td>
            </tr>
            {foreach from=$invoiceitem item=item}
            <tr>
                <td>{$item.description}</td>
                <td>{$item.amount}</td>
            </tr>
            {/foreach}
            {foreachelse}
            <tr>
                <td colspan="6">{$LANG.norecordsfound}</td>
            </tr>
            {/foreach}
            <tr class="subtotal">
                <td>{$LANG.invoicessubtotal}:</td>
                <td>{$subtotal}</td>
            </tr>
            {if $tax}<tr>
            <td>{$LANG.invoicestax}:</td>
            <td>{$tax}</td>
        </tr>{/if}
        {if $tax2}<tr>
        <td>{$LANG.invoicestax} 2:</td>
        <td>{$tax2}</td>
    </tr>{/if}
    {if $credit}<tr>
    <td>{$LANG.invoicescredit}:</td>
    <td>{$credit}</td>
</tr>{/if}
{if $partialpayments}<tr>
<td>{$LANG.invoicespartialpayments}:</td>
<td>{$partialpayments}</td>
</tr>{/if}
<tr>
    <td>{$LANG.invoicestotaldue}:</td>
    <td>{$total}</td>
</tr>
</tbody>
</table>
<div class="row">
<div class="col-md-6 col-md-offset-3">
<h3>{$LANG.orderpaymentmethod}</h3>
<div class="well">
<div class="form-group">
{foreach from=$gateways key=num item=gateway}
<div class="radio-inline">
    <label>
        <input type="radio" class="radio inline" name="paymentmethod" value="{$gateway.sysname}"{if $gateway.sysname eq $defaultgateway} checked{/if} /> {$gateway.name}
    </label>
</div>
{/foreach}
</div>
<div class="form-group">
<input type="submit" value="{$LANG.masspaymakepayment}" class="btn btn-success btn-lg btn-block" />
</div>
</div>
</div>
</div>
</form>
