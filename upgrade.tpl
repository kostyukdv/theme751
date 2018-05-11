{include file="$template/pageheader.tpl" title=$LANG.upgradedowngradepackage}
<div class="alert alert-block alert-info">
    <p>{$LANG.orderproduct}: <strong>{$groupname} - {$productname}</strong>{if $domain} ({$domain}){/if}</p>
</div>
{if $overdueinvoice}
<div class="row mx-1">
<div class="col-md-12">
<div class="well">{$LANG.upgradeerroroverdueinvoice}</div>
<input type="button" value="{$LANG.clientareabacklink}" onclick="window.location='clientarea.php?action=productdetails&id={$id}'" class="btn btn-default" />
</div>
</div>
{elseif $existingupgradeinvoice}
<div class="row px-1">
<div class="col-md-12">
<div class="well">{$LANG.upgradeexistingupgradeinvoice}</div>
<input type="button" value="{$LANG.clientareabacklink}" onclick="window.location='clientarea.php?action=productdetails&id={$id}'" class="btn btn-link" />
<input type="button" value="{$LANG.submitticketdescription}" onclick="window.location='submitticket.php'" class="btn btn-primary" />
</div>
</div>
{else}
{if $type eq "package"}
<h6 class="px-1">{$LANG.upgradechoosepackage}</h6>
<div class="row px-1">
{foreach key=num item=upgradepackage from=$upgradepackages}
<div class="col-md-4">
<div class="well clearfix text-center">
<form method="post" action="{$smarty.server.PHP_SELF}">
<input type="hidden" name="step" value="2">
<input type="hidden" name="type" value="{$type}">
<input type="hidden" name="id" value="{$id}">
<input type="hidden" name="pid" value="{$upgradepackage.pid}">
<h5>{$upgradepackage.groupname} - {$upgradepackage.name}</h5>
{if $upgradepackage.pricing.type eq "free"}
<h3>{$LANG.orderfree}</h3>
<input type="hidden" name="billingcycle" value="free">
{elseif $upgradepackage.pricing.type eq "onetime"}
{$upgradepackage.pricing.onetime} {$LANG.orderpaymenttermonetime}
<input type="hidden" name="billingcycle" value="onetime">
{elseif $upgradepackage.pricing.type eq "recurring"}
<div class="form-group">
<select name="billingcycle" class="form-control">
{if $upgradepackage.pricing.monthly}<option value="monthly">{$upgradepackage.pricing.monthly}</option>{/if}
{if $upgradepackage.pricing.quarterly}<option value="quarterly">{$upgradepackage.pricing.quarterly}</option>{/if}
{if $upgradepackage.pricing.semiannually}<option value="semiannually">{$upgradepackage.pricing.semiannually}</option>{/if}
{if $upgradepackage.pricing.annually}<option value="annually">{$upgradepackage.pricing.annually}</option>{/if}
{if $upgradepackage.pricing.biennially}<option value="biennially">{$upgradepackage.pricing.biennially}</option>{/if}
{if $upgradepackage.pricing.triennially}<option value="triennially">{$upgradepackage.pricing.triennially}</option>{/if}
</select>
</div>
{/if}
<input type="submit" value="{$LANG.upgradedowngradechooseproduct}" class="btn btn-default" />
</div>
</div>
</form>
{/foreach}
</div>


{elseif $type eq "configoptions"}

<p>{$LANG.upgradechooseconfigoptions}</p>

{if $errormessage}
<div class="alert alert-danger">
    <p>{$LANG.clientareaerrors}</p>
    <ul>
        {$errormessage}
    </ul>
</div>
{/if}

<form method="post" action="{$smarty.server.PHP_SELF}">
<input type="hidden" name="step" value="2" />
<input type="hidden" name="type" value="{$type}" />
<input type="hidden" name="id" value="{$id}" />

<table class="table table-striped table-framed">
    <thead>
        <tr>
            <th></th>
            <th class="textcenter">{$LANG.upgradecurrentconfig}</th>
            <th></th>
            <th class="textcenter">{$LANG.upgradenewconfig}</th>
        </tr>
    </thead>
    <tbody>
{foreach key=num item=configoption from=$configoptions}
        <tr>
            <td>{$configoption.optionname}</td>
            <td class="textcenter">
{if $configoption.optiontype eq 1 || $configoption.optiontype eq 2}
{$configoption.selectedname}
{elseif $configoption.optiontype eq 3}
{if $configoption.selectedqty}{$LANG.yes}{else}{$LANG.no}{/if}
{elseif $configoption.optiontype eq 4}
{$configoption.selectedqty} x {$configoption.options.0.name}
{/if}
            </td>
            <td class="textcenter">=></td>
            <td class="textcenter">
{if $configoption.optiontype eq 1 || $configoption.optiontype eq 2}
<select name="configoption[{$configoption.id}]">
{foreach key=num item=option from=$configoption.options}
{if $option.selected}<option value="{$option.id}" selected>{$LANG.upgradenochange}</option>{else}<option value="{$option.id}">{$option.nameonly} {$option.price}{/if}</option>
{/foreach}
</select>
{elseif $configoption.optiontype eq 3}
<input type="checkbox" name="configoption[{$configoption.id}]" value="1"{if $configoption.selectedqty} checked{/if}> {$configoption.options.0.name}
{elseif $configoption.optiontype eq 4}
<input type="text" name="configoption[{$configoption.id}]" value="{$configoption.selectedqty}" size="5"> x {$configoption.options.0.name}
{/if}
            </td>
        </tr>
{/foreach}
    </tbody>
</table>
<p><input type="submit" value="{$LANG.ordercontinuebutton}" class="btn btn-primary" /></p>
</form>
{/if}
{/if}
