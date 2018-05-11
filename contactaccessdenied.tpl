<div class="row px-1">
<div class="col-md-12">
{include file="$template/pageheader.tpl" title=$LANG.accessdenied}
<div class="alert alert-danger">
    <p>{$LANG.subaccountpermissiondenied}</p>
</div>
<p>{$LANG.subaccountallowedperms}</p>
<ul>
{foreach from=$allowedpermissions item=permission}
<li>{$permission}</li>
{/foreach}
</ul>
<p>{$LANG.subaccountcontactmaster}</p>
<p class="textcenter"><input type="button" value="{$LANG.clientareabacklink}" onclick="history.go(-1)" class="btn btn-default btn-sm" /></p>
</div>
</div>
