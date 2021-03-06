{* IMPORTANT! FILE WITH CUSTOM CHANGES *}
{include file="$template/pageheader.tpl" title=$LANG.clientareacancelrequest icon=power}
{if $invalid}
<div class="alert alert-warning">
    <p>{$LANG.clientareacancelinvalid}</p>
</div>
<div class="textcenter">
    <input type="button" value="{$LANG.clientareabacklink}" class="btn btn-default pull-right flip" onclick="window.location='clientarea.php?action=productdetails&id={$id}'" />
</div>
{elseif $requested}
<div class="alert alert-success">
    <p>{$LANG.clientareacancelconfirmation}</p>
</div>
<div class="textcenter">
    <input type="button" value="{$LANG.clientareabacklink}" class="btn btn-default" onclick="window.location='clientarea.php?action=productdetails&id={$id}'" />
</div>
{else}
{if $error}
<div class="alert alert-danger">
    <p class="bold">{$LANG.clientareaerrors}</p>
    <ul>
        <li>{$LANG.clientareacancelreasonrequired}</li>
    </ul>
</div>
{/if}
<div class="alert alert-warning">
    <p>{$LANG.clientareacancelproduct}: <strong>{$groupname} - {$productname}</strong>{if $domain} ({$domain}){/if}</p>
</div>
<form method="post" action="{$smarty.server.PHP_SELF}?action=cancel&amp;id={$id}" class="form-stacked">
<div class="row">
      <div class="col-md-6 col-md-offset-3">
    <input type="hidden" name="sub" value="submit" />
    <fieldset class="control-group">
        <div class="form-group">
            <label class="control-label" for="cancellationreason">{$LANG.clientareacancelreason}</label>
            <textarea name="cancellationreason" id="cancellationreason" rows="6" class="form-control"></textarea>
        </div>
        <div class="form-group">
            <label class="control-label" for="type">{$LANG.clientareacancellationtype}</label>
            <select name="type" class="form-control" id="type">
                <option value="Immediate">{$LANG.clientareacancellationimmediate}</option>
                <option value="End of Billing Period">{$LANG.clientareacancellationendofbillingperiod}</option>
            </select>
        </div>
        {* hostpro start*} 
        {*if $domainid}
        <div class="alert alert-block alert-warning">
            <h4>{$LANG.cancelrequestdomain}</h4>
            <p>{$LANG.cancelrequestdomaindesc|sprintf2:$domainnextduedate:$domainprice:$domainregperiod}</p>
        </div>
        <div class="checkbox"><label><input type="checkbox" name="canceldomain" id="canceldomain" />{$LANG.cancelrequestdomainconfirm}</label></div>
        {/if*}
        {* hostpro end *}

            <input type="submit" value="{$LANG.clientareacancelrequestbutton}" class="btn btn-danger btn-lg btn-block" />
    </fieldset>
</div>
</div>
</form>
{/if}
