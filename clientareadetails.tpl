{* IMPORTANT! FILE WITH CUSTOM CHANGES *}
<h3 class="page-header"><span aria-hidden="true" class="icon icon-user"></span> {$LANG.clientareanavdetails}</h3>
<script type="text/javascript" src="{$BASE_PATH_JS}/StatesDropdown.js"></script>
{include file="$template/clientareadetailslinks.tpl"}
{if $successful}
{include file="$template/includes/alert.tpl" type="success" msg=$LANG.changessavedsuccessfully textcenter=true}
{/if}
{if $errormessage}
{include file="$template/includes/alert.tpl" type="error" errorshtml=$errormessage}
{/if}
{* uniweb start *}
<br>
{if empty($clientstate)} <div class="alert alert-warning">{$LANG.clientprofileerrorstate}</div>{/if}
{if empty($clientaddress1)} <div class="alert alert-warning">{$LANG.clientprofileerroraddress1}</div>{/if}
{if empty($clientcity)} <div class="alert alert-warning">{$LANG.clientprofileerrorcity}</div>{/if}
{if empty($clientphonenumber)} <div class="alert alert-warning">{$LANG.clientprofileerrorphone}</div>{/if}
{if empty($clientpostcode)} <div class="alert alert-warning">{$LANG.clientprofileerrorpostal}</div>{/if}
{* uniweb end *}
<form method="post" action="{$smarty.server.PHP_SELF}?action=details" role="form" class="form-horizontal p-2">
  <div class="form-group st-input">
    <label for="inputFirstName" class="col-sm-2 control-label">{$LANG.clientareafirstname}</label>
    <div class="col-sm-10">
      <input type="text" name="firstname" id="inputFirstName" value="{$clientfirstname}"{if in_array('firstname', $uneditablefields)} disabled="disabled"{/if} class="form-control" />
    </div>
  </div>
  <div class="form-group st-input">
    <label for="inputLastName" class="col-sm-2 control-label">{$LANG.clientarealastname}</label>
    <div class="col-sm-10">
      <input type="text" name="lastname" id="inputLastName" value="{$clientlastname}"{if in_array('lastname', $uneditablefields)} disabled="disabled"{/if} class="form-control" />
    </div>
  </div>
  {* hostpro start *}
  {if $clientsdetails.customfields1 eq $smarty.const.CLIENT_TYPE_FIZ}
  <div class="form-group st-input" style="display: none;">
	<label for="inputCompanyName" class="col-sm-2 control-label">{$LANG.clientareacompanyname}</label>
	<input type="text" name="companyname" id="inputCompanyName" value="{$clientcompanyname}"{if in_array('companyname', $uneditablefields)} disabled="disabled"{/if} class="form-control" />
  </div>
  {else}
  {* hostpro end *}
  <div class="form-group st-input">
    <label for="inputCompanyName" class="col-sm-2 control-label">{$LANG.clientareacompanyname}</label>
    <div class="col-sm-6">
      <input type="text" name="companyname" id="inputCompanyName" value="{$clientcompanyname}"{if in_array('companyname', $uneditablefields)} disabled="disabled"{/if} class="form-control" />
    </div>
  </div>
  {* hostpro start *}
  {/if}
  {* hostpro end *}
  <div class="form-group st-input">
    <label for="inputEmail" class="col-sm-2 control-label">{$LANG.clientareaemail}</label>
    <div class="col-sm-10">
      <input type="email" name="email" id="inputEmail" value="{$clientemail|lower}"{if in_array('email', $uneditablefields)} disabled="disabled"{/if} class="form-control" />
    </div>
  </div>
  {* uniweb start *}
    {foreach from=$customfields key=num item=customfield}
    {if $customfield.id eq $smarty.const.CUSTOMFIELD_TAX_MAIL}
        <div class="form-group st-input" style="display: none;">
        <label class="control-label" style="color: #b94a48;" for="customfield{$customfield.id}">{$customfield.name}</label>
        <div class="controls">
        {$customfield.input}<span style="color: #b94a48;">{$customfield.description}</span>
        </div>
        </div>
    {/if}
    {/foreach}
  {* uniweb end *}
  <div class="form-group st-input">
    <label for="inputPhone" class="col-sm-2 control-label">{$LANG.clientareaphonenumber}</label>
    <div class="col-sm-10">
      <input type="tel" name="phonenumber" id="inputPhone" value="{$clientphonenumber}"{if in_array('phonenumber',$uneditablefields)} disabled=""{/if} class="form-control" />
    </div>
  </div>
  <hr>
  <div class="form-group st-input">
    <label for="inputAddress1" class="col-sm-2 control-label">{$LANG.clientareaaddress1}</label>
    <div class="col-sm-10">
      <input type="text" name="address1" id="inputAddress1" value="{$clientaddress1}"{if in_array('address1', $uneditablefields)} disabled="disabled"{/if} class="form-control" />
    </div>
  </div>
  {*
  <div class="form-group">
    <label for="inputAddress2" class="col-sm-2 control-label">{$LANG.clientareaaddress2}</label>
    <div class="col-sm-10">
      <input type="text" name="address2" id="inputAddress2" value="{$clientaddress2}"{if in_array('address2', $uneditablefields)} disabled="disabled"{/if} class="form-control" />
    </div>
  </div>
  *}
  <div class="form-group st-input">
    <label for="inputCity" class="col-sm-2 control-label">{$LANG.clientareacity}</label>
    <div class="col-sm-10">
      <input type="text" name="city" id="inputCity" value="{$clientcity}"{if in_array('city', $uneditablefields)} disabled="disabled"{/if} class="form-control" />
    </div>
  </div>
  <div class="form-group st-input">
    <label for="inputState" class="col-sm-2 control-label">{$LANG.clientareastate}</label>
    <div class="col-sm-6">
      <input type="text" name="state" id="inputState" value="{$clientstate}"{if in_array('state', $uneditablefields)} disabled="disabled"{/if} class="form-control" />
    </div>
  </div>
  <div class="form-group st-input">
    <label for="inputPostcode" class="col-sm-2 control-label">{$LANG.clientareapostcode}</label>
    <div class="col-sm-10">
      <input type="text" name="postcode" id="inputPostcode" value="{$clientpostcode}"{if in_array('postcode', $uneditablefields)} disabled="disabled"{/if} class="form-control" />
    </div>
  </div>
  <div class="form-group st-input">
    <label for="country" class="col-sm-2 control-label">{$LANG.clientareacountry}</label>
    <div class="col-sm-6">
      {$clientcountriesdropdown}
    </div>
  </div>
  <hr>
  <div class="form-group st-input">
    <label for="inputPaymentMethod" class="col-sm-2 control-label">{$LANG.paymentmethod}</label>
    <div class="col-sm-6">
      <select name="paymentmethod" id="inputPaymentMethod" class="form-control">
        <option value="none">{$LANG.paymentmethoddefault}</option>
		{* uniweb start *}
        {* {foreach from=$paymentmethods item=method} *}
        {foreach from=$customGateways item=method}
        {* uniweb end *}
        <option value="{$method.sysname}"{if $method.sysname eq $defaultpaymentmethod} selected="selected"{/if}>{$method.name}</option>
        {/foreach}
      </select>
    </div>
  </div>
  {*
  <div class="form-group">
    <label for="inputBillingContact" class="col-sm-2 control-label">{$LANG.defaultbillingcontact}</label>
    <div class="col-sm-6">
      <select name="billingcid" id="inputBillingContact" class="form-control">
        <option value="0">{$LANG.usedefaultcontact}</option>
        {foreach from=$contacts item=contact}
        <option value="{$contact.id}"{if $contact.id eq $billingcid} selected="selected"{/if}>{$contact.name}</option>
        {/foreach}
      </select>
    </div>
  </div>
  
  {if $customfields}
  {foreach from=$customfields key=num item=customfield}
  <div class="form-group">
    <label for="customfield{$customfield.id}" class="col-sm-2 control-label">{$customfield.name}</label>
    <div class="col-sm-6">
      <div class="control">
        {$customfield.input} {$customfield.description}
      </div>
    </div>
  </div>
  {/foreach}
  {/if}
  *}
  
  {* uniweb start *}
        {if $clientsdetails.customfields1 eq $smarty.const.CLIENT_TYPE_FIZ}

            {foreach from=$customfields key=num item=customfield}
                {if $customfield.id eq $smarty.const.CUSTOMFIELD_RECEIVE_SMS}
                    {assign var="viewField" value=""}
                {elseif $customfield.id eq $smarty.const.CUSTOMFIELD_CLOUD_NOTIFY && $useCloud}
                    {assign var="viewField" value=""}
                {else}
                    {assign var="viewField" value="style='display: none;'"}
                {/if}
                <div class="form-group" {$viewField} >
                    <label class="control-label" for="customfield{$customfield.id}">{$customfield.name}</label>
                    <div class="controls">
                        {$customfield.input} {$customfield.description}
                    </div>
                </div>
            {/foreach}

        {else}

            {foreach from=$customfields key=num item=customfield}
            {if $customfield.id != $smarty.const.CUSTOMFIELD_TAX_MAIL}
                {if $customfield.id eq $smarty.const.CUSTOMFIELD_CLOUD_NOTIFY && !$useCloud}
                    {assign var="viewField" value="style='display: none;'"}
                {else}
                    {assign var="viewField" value=""}
                {/if}

                <div class="form-group" {$viewField}>
                    <label class="control-label" for="customfield{$customfield.id}">{$customfield.name}</label>
                    <div class="controls">
                        {if $customfield.value eq "Юр. лицо" or $customfield.value eq "Частный предприниматель"}
                            <select name="customfield[{$customfield.id}]" id="customfield{$customfield.id}"><option value="{$customfield.value}" >{$customfield.value}</option></select>
                        {elseif defined('CUSTOMFIELD_EKPO') && CUSTOMFIELD_EKPO === $customfield.id}
                            {$customfield.input|replace:'<input type="text"':'<input type="text" readonly'} {$customfield.description}
                        {else}
                            {$customfield.input} {$customfield.description}
                        {/if}
                    </div>
                </div>
            {/if}
            {/foreach}

        {/if}

        <div class="alert alert-info">
            <button type="button" class="close" data-dismiss="alert">&times;</button>
            {$LANG.sms_sending_rules} {* added by nick@hostpro.ua *}
    </div>
  {* uniweb end *}
  
  {if $emailoptoutenabled}
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <div class="checkbox">
        <label>
          <input type="checkbox">  <input type="checkbox" value="1" name="emailoptout" id="inputEmailOptOut" {if $emailoptout} checked{/if} /> {$LANG.emailoptoutdesc}
        </label>
      </div>
    </div>
  </div>
  {/if}
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <input class="btn btn-primary" type="submit" name="save" value="{$LANG.clientareasavechanges}" />
    </div>
  </div>
</form>

{* uniweb start *}
{if $clientsdetails.customfields1 eq $smarty.const.CLIENT_TYPE_UR}
<script>
var customfieldTaxType = "{$smarty.const.CUSTOMFIELD_TAX_TYPE}";
var customfieldTaxMail = "{$smarty.const.CUSTOMFIELD_TAX_MAIL}";

$(document).ready(function(){
  $("#customfield"+customfieldTaxType).on("change", function(){
    if ($(this).val() == "Плательщик НДС") {
      $("#customfield"+customfieldTaxMail).parent().parent().slideDown(100);
    }
    else {
      $("#customfield"+customfieldTaxMail).parent().parent().slideUp(100);
    }
  }).trigger("change");
});

</script>
{/if}
{* uniweb end *}
