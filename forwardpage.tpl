<div class="container">
  <div class="alert alert-block alert-warning textcenter">
    <h4><i class="fa fa-circle-o-notch fa-spin fa-lg fa-fw"></i> {$message}</h4>
  </div>

  <div id="submitfrm">
    <div class="form-group">{$code}</div>
    <form method="post" action="{if $invoiceid}viewinvoice.php?id={$invoiceid}{else}clientarea.php{/if}">
    </form>
  </div>
</div>

{literal}
<script language="javascript">
  setTimeout("autoForward()", 5000);
  function autoForward() {
    var submitForm = jQuery("#submitfrm").find("form:first");
    submitForm.submit();
  }
</script>
{/literal}
