{include file="$template/pageheader.tpl" title=$LANG.domaingeteppcode desc=$LANG.domaingeteppcodeexplanation}
<div class="alert alert-block alert-info">
<h4>{$LANG.domainname}: {$domain}</h4>
</div>

{if $error}
<div class="alert alert-danger">
    {$LANG.domaingeteppcodefailure} {$error}
</div>
{else}
    {if $eppcode}
    <div class="alert alert-default">
        {$LANG.domaingeteppcodeis} {$eppcode}
    </div>
    {else}
    <div class="alert alert-default">
        {$LANG.domaingeteppcodeemailconfirmation}
    </div>
    {/if}
{/if}
<form method="post" action="{$smarty.server.PHP_SELF}?action=domaindetails">
<input type="hidden" name="id" value="{$domainid}" />
<p class="px-1"><input type="submit" value="{$LANG.clientareabacklink}" class="btn btn-default" /></p>
</form>
