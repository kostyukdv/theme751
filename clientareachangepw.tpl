{include file="$template/pageheader.tpl" title=$LANG.clientareanavchangepw}

{include file="$template/clientareadetailslinks.tpl"}

{if $successful}
<div class="alert alert-success">
    <p>{$LANG.changessavedsuccessfully}</p>
</div>
{/if}

{if $errormessage}
<div class="alert alert-danger">
    <p class="bold">{$LANG.clientareaerrors}</p>
    <ul>
        {$errormessage}
    </ul>
</div>
{/if}

<form method="post" action="{$smarty.server.PHP_SELF}?action=changepw" class="form-horizontal p-2">
  <div class="form-group st-input">
    <label for="existingpw" class="col-sm-2 control-label">{$LANG.existingpassword}</label>
    <div class="col-sm-10 col-md-6">
      <input type="password" class="form-control" name="existingpw" id="existingpw" autocomplete="off" />
    </div>
  </div>
  <div class="form-group st-input">
    <label for="password" class="col-sm-2 control-label">{$LANG.newpassword}</label>
    <div class="col-sm-10 col-md-6">
      <input type="password" name="newpw" class="form-control" id="password" autocomplete="off" />
    </div>
  </div>

  <div class="form-group st-input">
    <label for="confirmpw" class="col-sm-2 control-label">{$LANG.confirmnewpassword}</label>
    <div class="col-sm-10 col-md-6">
      <input type="password" class="form-control" name="confirmpw" id="confirmpw" autocomplete="off" />
    </div>
  </div>

  <div class="form-group">
  <div class="col-sm-offset-2 col-sm-10 col-md-6">
  {include file="$template/pwstrength.tpl"}
  </div>
</div>

  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <input class="btn btn-primary" type="submit" name="submit" value="{$LANG.clientareasavechanges}" />
    </div>
  </div>
</form>
