<link rel="stylesheet" type="text/css" href="{$BASE_PATH_CSS}/dataTables.bootstrap.css">
<script type="text/javascript" charset="utf8" src="{$BASE_PATH_JS}/jquery.dataTables.min.js"></script>
<script type="text/javascript" charset="utf8" src="{$BASE_PATH_JS}/dataTables.bootstrap.min.js"></script>

{include file="$template/pageheader.tpl" title=$LANG.clientareanavsecurity icon=lock}
{include file="$template/clientareadetailslinks.tpl"}
{if $successful}
<div class="alert alert-success">
  <p>{$LANG.changessavedsuccessfully}</p>
</div>
{/if}
{if $errormessage}
<div class="alert alert-danger">
  <p>{$LANG.clientareaerrors}</p>
  <ul>
    {$errormessage}
  </ul>
</div>
{/if}

{if $linkableProviders }
<div class="p-2">
    <h2>
        {lang key='remoteAuthn.titleLinkedAccounts'}
    </h2>
    {include file="$template/includes/linkedaccounts.tpl" linkContext="clientsecurity" }
    {include file="$template/includes/linkedaccounts.tpl" linkContext="linktable" }
</div>
{/if}

{if $twofaavailable}
{if $twofaactivation}
<div id="twofaactivation">
  {$twofaactivation}
</div>
<script type="text/javascript">
jQuery("#twofaactivation input:text:visible:first,#twofaactivation input:password:visible:first").focus();
</script>
{else}
{include file="$template/subheader.tpl" title=$LANG.twofactorauth}
    <div class="alert alert-info">{$LANG.twofaactivationintro}
    <form method="post" action="clientarea.php?action=security">
      <input type="hidden" name="2fasetup" value="1" />
      <div class="form-group">
        {if $twofastatus}
        <input type="submit" value="{$LANG.twofadisableclickhere}" class="btn btn-danger" />
        {else}
        <input type="submit" value="{$LANG.twofaenableclickhere}" class="btn btn-success" />
        {/if}
      </div>
    </form>
    </div>
{/if}
{/if}
{if $securityquestionsenabled && !$twofaactivation}
{include file="$template/subheader.tpl" title=$LANG.clientareanavsecurityquestions}
<form method="post" action="{$smarty.server.PHP_SELF}?action=changesq" class="form-horizontal p-2">
  {if !$nocurrent}
  <div class="form-group">
    <label for="currentans" class="col-sm-2 control-label">{$currentquestion}</label>
    <div class="col-sm-10">
      <input type="password" class="form-control" name="currentsecurityqans" id="currentans" autocomplete="off" />
    </div>
  </div>
  {/if}
  <div class="form-group">
    <label for="securityqid" class="col-sm-2 control-label">{$LANG.clientareasecurityquestion}</label>
    <div class="col-sm-6">
      <select name="securityqid" class="form-control" id="securityqid">
        {foreach key=num item=question from=$securityquestions}
        <option value={$question.id}>{$question.question}</option>
        {/foreach}
      </select>
    </div>
  </div>
  <div class="form-group">
    <label for="securityqans" class="col-sm-2 control-label">{$LANG.clientareasecurityanswer}</label>
    <div class="col-sm-10">
      <input type="password" class="form-control" name="securityqans" id="securityqans" autocomplete="off" />
    </div>
  </div>
  <div class="form-group">
    <label for="securityqans2" class="col-sm-2 control-label">{$LANG.clientareasecurityconfanswer}</label>
    <div class="col-sm-10">
      <input type="password" class="form-control" name="securityqans2" id="securityqans2" autocomplete="off" />
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <input class="btn btn-primary" type="submit" name="submit" value="{$LANG.clientareasavechanges}" />
    </div>
  </div>
</form>
{/if}


{if $showSsoSetting && !$twofaactivation}

<h2>{$LANG.sso.title}</h2>

{include file="$template/includes/alert.tpl" type="success" msg=$LANG.sso.summary}

<form id="frmSingleSignOn">
  <input type="hidden" name="token" value="{$token}" />
  <input type="hidden" name="action" value="security" />
  <input type="hidden" name="toggle_sso" value="1" />
  <div class="margin-10">
    <input type="checkbox" name="allow_sso" class="toggle-switch-success" id="inputAllowSso"{if $isSsoEnabled} checked{/if}>
    &nbsp;
    <span id="ssoStatusTextEnabled"{if !$isSsoEnabled} class="hidden"{/if}>
      {$LANG.sso.enabled}
    </span>
    <span id="ssoStatusTextDisabled"{if $isSsoEnabled} class="hidden"{/if}>
      {$LANG.sso.disabled}
    </span>
  </div>
</form>
<p>{$LANG.sso.disablenotice}</p>
<link href="{$BASE_PATH_CSS}/bootstrap-switch.min.css" rel="stylesheet">
<script src="{$BASE_PATH_JS}/bootstrap-switch.min.js"></script>
{/if}
