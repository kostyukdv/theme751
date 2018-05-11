{include file="$template/pageheader.tpl" title=$LANG.newsletterunsubscribe}
<div class="row px-1">
<div class="col-md-12">
  {if $successful}
  <div class="alert alert-success">
      <p>{$LANG.unsubscribesuccess}</p>
  </div>
  <p>{$LANG.newsletterremoved}</p>
  {/if}
  {if $errormessage}
  <div class="alert alert-danger">
      <p>{$LANG.erroroccured}</p>
  </div>
  <p>{$errormessage}</p>
  {/if}
  <p>{$LANG.newsletterresubscribe|sprintf2:'<a href="clientarea.php?action=details">':'</a>'}</p>
</div>
</div>
