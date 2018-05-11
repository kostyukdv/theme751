{if $errormessage}
{include file="$template/pageheader.tpl" title=$LANG.sslconfsslcertificate}
<div class="alert alert-danger">
  <p>{$LANG.clientareaerrors}</p>
  <ul>
    {$errormessage}
  </ul>
  <input type="button" value="{$LANG.clientareabacklink}" class="btn btn-default btn-sm" onclick="history.go(-1)" />
</div>
{else}
{include file="$template/pageheader.tpl" title=$LANG.sslconfigcomplete}
<p>{$LANG.sslconfigcompletedetails}</p>
<form method="post" action="clientarea.php?action=productdetails" class="px-1">
  <input type="hidden" name="id" value="{$serviceid}" />
  <div class="form-group">
    <input type="submit" value="{$LANG.invoicesbacktoclientarea}" class="btn btn-default btn-sm"/>
  </div>
</form>
{/if}
