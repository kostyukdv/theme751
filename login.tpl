{if $hexa_minimal == 0}
{include file="$template/pageheader.tpl" title=$LANG.login icon='login'}
{/if}
 <div class="row py-1">
  <div class="col-md-4 col-md-offset-4 box">
    <div class="content-wrap">
      {if $hexa_minimal == 1}<div class="text-right py-2"><a class="text-uppercase" href="register.php">{$LANG.signup}</a></div>{/if}
      <p class="text-danger bg-danger text-alert {if !$incorrect} displaynone{/if}" id="login-error"><strong><span aria-hidden="true" class="icon icon-ban"></span> {$LANG.warning}</strong><br/>{$LANG.loginincorrect}</p>
       <div class="providerLinkingFeedback"></div>
      {if $verificationId && empty($transientDataName)}
      <p class="text-danger bg-danger">{$LANG.verificationKeyExpired}</p>
      {elseif $ssoredirect}
      <p class="text-info bg-info"><i class="fa fa-external-link-square"></i> {$LANG.sso.redirectafterlogin}</p>
      {/if}
      <form method="post" action="{$systemurl}dologin.php">
        <div class="form-group">
          <div class="input-group input-group-lg">
            <span class="input-group-addon"><span aria-hidden="true" class="icon icon-envelope"></span></span>
            <input class="form-control" name="username" type="text" placeholder="{$LANG.loginemail}">
          </div>
        </div>
        <div class="form-group">
          <div class="input-group input-group-lg">
            <span class="input-group-addon"><span aria-hidden="true" class="icon icon-lock"></span></span>
            <input class="form-control" name="password" type="password" placeholder="{$LANG.loginpassword}" autocomplete="off">
          </div>
        </div>
        <a href="pwreset.php" class="forgot">{$LANG.loginforgotteninstructions}</a>
       <div class="form-group text-left">
       <label class="checkbox-inline">
         <input type="checkbox" name="rememberme" id="rememberme">{$LANG.loginrememberme}
       </label>
     </div>
        <div class="row">
         <div class="col-md-12">
          <div class="form-group"><input type="submit" name="submit" class="btn btn-primary btn-lg btn-block" value="{$LANG.loginbutton}"></div>
        </div>
      </div>
    </form>
  </div>
</div>

<div class="col-md-4 col-md-offset-4 box box-inverse {if !$linkableProviders} hidden{/if}">
  <div class="content-wrap">
  <h6 class="py-1 m-0">{$LANG.signinwith}</h6>
  {include file="$template/includes/linkedaccounts.tpl" linkContext="login" customFeedback=true}
</div>
</div>
</div>
{if $hexa_minimal == 1}
<div class="languageblock">
{include file="$template/languageblock.tpl"}
</div>
{/if}
