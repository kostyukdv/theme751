{if in_array('state', $optionalFields)}
<script>
var stateNotRequired = true;
</script>
{/if}
<script type="text/javascript" src="{$BASE_PATH_JS}/StatesDropdown.js"></script>
{if $hexa_minimal == 0}{include file="$template/pageheader.tpl" title=$LANG.clientregistertitle desc=$LANG.registerintro icon=user}{/if}
{if $registrationDisabled}
{include file="$template/includes/alert.tpl" type="error" msg=$LANG.registerCreateAccount|cat:' <strong><a href="cart.php" class="alert-link">'|cat:$LANG.registerCreateAccountOrder|cat:'</a></strong>'}
{/if}
{if $errormessage}
{include file="$template/includes/alert.tpl" type="error" errorshtml=$errormessage}
{/if}
{if !$registrationDisabled}
<div class="row py-2">
<div class="col-md-6 col-md-offset-3">
<form method="post" class="register-form using-password-strength" action="{$smarty.server.PHP_SELF}" role="form">
  <input type="hidden" name="register" value="true"/>
  <div class="{*well well-register*}">
  {if $hexa_minimal == 1}<h6>{$LANG.clientregistertitle}</h6>{/if}
  <div class="py-1">
 {*include file="$template/includes/linkedaccounts.tpl" linkContext="registration"*}
 </div>
    <div class="row">
    {*hostpro start*}
      <div class="col-md-6">
          <div class="form-group form-group-xl user-type st-input">
             <label class="control-label"><span data-original-title="{$customfields[0].description}" data-toggle="tooltip"></span>{$customfields[0].name}</label>
             {$customfields[0].input}
          </div>
      </div>
    </div>
    <div class="row">
    {*hostpro end*} 
      <div class="col-md-6">
        <div class="form-group st-input">
          <label for="firstname" class="control-label">{$LANG.clientareafirstname}</label>
          <input type="text" name="firstname" id="firstname" value="{$clientfirstname}" class="form-control" {if !in_array('firstname', $optionalFields)}required{/if} />
        </div>
      </div>
      <div class="col-md-6">
        <div class="form-group st-input">
          <label for="lastname" class="control-label">{$LANG.clientarealastname}</label>
          <input type="text" name="lastname" id="lastname" value="{$clientlastname}" class="form-control" {if !in_array('lastname', $optionalFields)}required{/if} />
        </div>
      </div>
    </div>
    <div class="row">
      {*<div class="col-md-6">
        <div class="form-group">
          <label for="companyname" class="control-label">{$LANG.clientareacompanyname}</label>
          <input type="text" name="companyname" id="companyname" value="{$clientcompanyname}" class="form-control"/>
        </div>
      </div>*}
      <div class="col-md-6">
        <div class="form-group st-input">
          <label for="phonenumber" class="control-label">{$LANG.clientareaphonenumber}</label>
          <input type="tel" name="phonenumber" id="phonenumber" value="{$clientphonenumber}" class="form-control" {if !in_array('phonenumber', $optionalFields)}required{/if} />
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-8">
        <div class="form-group st-input">
          <label for="email" class="control-label">{$LANG.clientareaemail}</label>
          <input type="email" name="email" id="email" value="{$clientemail}" class="form-control"/>
        </div>
      </div>
      <div class="col-md-6">
      </div>
    </div>
  </div>
 <div class="{*well well-register*}">
    <div class="row">
      <div class="col-md-6">
        <div id="newPassword1" class="form-group has-feedback st-input">
          <label for="inputNewPassword1" class="control-label">{$LANG.clientareapassword}</label>
          <input type="password" class="form-control" id="inputNewPassword1" name="password" autocomplete="off" />
          <span class="form-control-feedback glyphicon glyphicon-password"></span>
        </div>
        <div id="newPassword2" class="form-group has-feedback st-input">
          <label for="inputNewPassword2" class="control-label">{$LANG.clientareaconfirmpassword}</label>
          <input type="password" class="form-control" id="inputNewPassword2" name="password2" autocomplete="off" />
          <span class="form-control-feedback glyphicon glyphicon-password"></span>
          <div id="inputNewPassword2Msg">
          </div>
        </div>
      </div>
      <div class="col-md-6">
        {include file="$template/includes/pwstrength.tpl"}
      </div>
    </div>
  </div>
 <div class="{*well well-register*}">
    <div class="row">
     <div class="col-md-12">
        <div class="form-group st-input">
          <label for="address1" class="control-label">{$LANG.clientareaaddress1}</label>
          <input type="text" name="address1" id="address1" value="{$clientaddress1}" class="form-control" {if !in_array('address1', $optionalFields)}required{/if} />
        </div>
      </div>
   </div>
   <div class="row">
      <div class="col-md-7">
        <div class="form-group st-input">
          <label for="country" class="control-label">{$LANG.clientareacountry}</label>
          <select id="country" name="country" class="form-control">
            {foreach $clientcountries as $countryCode => $countryName}
            <option value="{$countryCode}"{if (!$clientcountry && $countryCode eq $defaultCountry) || ($countryCode eq $clientcountry)} selected="selected"{/if}>
              {$countryName}
            </option>
            {/foreach}
          </select>
        </div>
      </div>
    </div>
   <div class="row">
      <div class="col-md-4">
        <div class="form-group st-input">
          <label for="city" class="control-label">{$LANG.clientareacity}</label>
          <input type="text" name="city" id="city" value="{$clientcity}" class="form-control" {if !in_array('city', $optionalFields)}required{/if} />
        </div>
      </div>
     <div class="col-md-4">
        <div class="form-group st-input">
          <label for="state" class="control-label">{$LANG.clientareastate}</label>
          <input type="text" name="state" id="state" value="{$clientstate}" class="form-control" {if !in_array('state', $optionalFields)}required{/if} />
        </div>
      </div>
     <div class="col-md-4">
        <div class="form-group st-input">
          <label for="postcode" class="control-label">{$LANG.clientareapostcode}</label>
          <input type="text" name="postcode" id="postcode" value="{$clientpostcode}" class="form-control" {if !in_array('postcode', $optionalFields)}required{/if} />
        </div>
      </div>
   </div>
  </div>
  {if $customfields || $currencies}
 <div class="{*well well-register*}">
    <div class="row">
 {*   {if $customfields}
      <div class="col-md-6">
        {foreach from=$customfields key=num item=customfield}
        <div class="form-group">
          <label class="control-label" for="customfield{$customfield.id}">{$customfield.name}</label>
          <div class="control">
            {$customfield.input} {$customfield.description}
          </div>
        </div>
        {/foreach}
      </div>
      {/if} *}
  {if $currencies}
     <div class="col-md-3">
        <div class="form-group">
          <label for="currency" class="control-label">{$LANG.choosecurrency}</label>
          <select id="currency" name="currency" class="form-control">
            {foreach from=$currencies item=curr}
            <option value="{$curr.id}"{if !$smarty.post.currency && $curr.default || $smarty.post.currency eq $curr.id } selected{/if}>{$curr.code}</option>
            {/foreach}
          </select>
        </div>
     </div>
     {/if}
   </div>
 </div>
 {/if}
  {if $securityquestions}
  <div class="well well-register">
    <div class="row">
      <div class="col-md-6">
        <div class="form-group">
          <label class="control-label" for="securityqid">{$LANG.clientareasecurityquestion}</label>
          <select name="securityqid" id="securityqid" class="form-control">
            {foreach key=num item=question from=$securityquestions}
            <option value={$question.id}>{$question.question}</option>
            {/foreach}
          </select>
        </div>
      </div>
      <div class="col-md-6">
        <div class="form-group">
          <label class="control-label" for="securityqans">{$LANG.clientareasecurityanswer}</label>
          <input type="password" name="securityqans" id="securityqans" class="form-control" autocomplete="off" />
        </div>
      </div>
    </div>
  </div>
  {/if}
 {include file="$template/includes/captcha.tpl"}
    {if $accepttos}
{*hostpro start*}
<div class="checkbox">
            <label class="checkbox-inline" style="font-size: 14px;">
                <input type="checkbox" required/>
                {$LANG.order_form_validation}
                 <a href="https://hostpro.ua/zgoda.html" target="_blank" style="color: orange;">{$LANG.order_form_tos}</a>
            </label>
</div>
{*hostpro end*}

      <div class="checkbox">
        <label>
        <input type="checkbox" name="accepttos"> {$LANG.ordertosagreement}<a href="{$tosurl}" target="_blank" style="color: orange;"> {$LANG.ordertos}</a>
      </label>
      </div>
    {/if}
      <input class="btn btn-lg btn-block btn-primary" type="submit" value="{$LANG.clientregistertitle}"/>
</form>
</div>
</div>
{/if}
{if $hexa_minimal == 1}
<div class="languageblock">
{include file="$template/languageblock.tpl"}
</div>
{/if}
