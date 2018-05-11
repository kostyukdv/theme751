{* IMPORTANT! FILE WITH CUSTOM CHANGES *}
<script type="text/javascript" src="{$BASE_PATH_JS}/StatesDropdown.js"></script>
{include file="$template/pageheader.tpl" title=$LANG.clientareanavcontacts}
{include file="$template/clientareadetailslinks.tpl"}

{if $errormessage}
{include file="$template/includes/alert.tpl" type="error" errorshtml=$errormessage}
{/if}

<script>
var stateNotRequired = true;
</script>

<script type="text/javascript" src="{$BASE_PATH_JS}/StatesDropdown.js"></script>

  <form class="form-horizontal p-2" role="form" method="post" action="{$smarty.server.PHP_SELF}?action=contacts">
    <div class="form-group st-input st-input-select">
      <label for="inputContactID" class="col-sm-2 control-label">{$LANG.clientareachoosecontact}</label>
        <div class="col-sm-10">
      <select name="contactid" id="inputContactID" onchange="submit()" class="form-control">
        {foreach item=contact from=$contacts}
        <option value="{$contact.id}">{$contact.name} - {$contact.email}</option>
        {/foreach}
        <option value="new" selected="selected">{$LANG.clientareanavaddcontact}</option>
      </select>
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
    <button type="submit" class="btn btn-default">{$LANG.go}</button>
  </div>
</div>
  </form>

<form role="form" method="post" action="{$smarty.server.PHP_SELF}?action=addcontact" class="form-horizontal p-2">
  <input type="hidden" name="submit" value="true" />
  <div class="form-group st-input">
    <label for="inputFirstName" class="col-sm-2 control-label">{$LANG.clientareafirstname}</label>
    <div class="col-sm-10">
      <input type="text" name="firstname" id="inputFirstName" value="{$contactfirstname}" class="form-control" />
    </div>
  </div>

  <div class="form-group st-input">
    <label for="inputLastName" class="col-sm-2 control-label">{$LANG.clientarealastname}</label>
    <div class="col-sm-10">
      <input type="text" name="lastname" id="inputLastName" value="{$contactlastname}" class="form-control" />
    </div>
  </div>

  <div class="form-group st-input">
    <label for="inputCompanyName" class="col-sm-2 control-label">{$LANG.clientareacompanyname}</label>
    <div class="col-sm-10">
      <input type="text" name="companyname" id="inputCompanyName" value="{$contactcompanyname}" class="form-control" />
    </div>
  </div>

  <div class="form-group st-input"> 
    <label for="inputEmail" class="col-sm-2 control-label">{$LANG.clientareaemail}</label>
    <div class="col-sm-10">
      <input type="email" name="email" id="inputEmail" value="{$contactemail|lower}" class="form-control" />
    </div>
  </div>

  <div class="form-group st-input">
    <label for="inputPhone" class="col-sm-2 control-label">{$LANG.clientareaphonenumber}</label>
    <div class="col-sm-10">
      <input type="tel" name="phonenumber" id="inputPhone" value="{$contactphonenumber}" class="form-control" />
    </div>
  </div>

  <div class="form-group st-input">
    <label for="inputAddress1"  class="col-sm-2 control-label">{$LANG.clientareaaddress1}</label>
    <div class="col-sm-10">
      <input type="text" name="address1" id="inputAddress1" value="{$contactaddress1}" class="form-control" />
    </div>
  </div>

  {*<div class="form-group">
    <label for="inputAddress2" class="col-sm-2 control-label">{$LANG.clientareaaddress2}</label>
    <div class="col-sm-10">
      <input type="text" name="address2" id="inputAddress2" value="{$contactaddress2}" class="form-control" />
    </div>
  </div>*}

  <div class="form-group st-input">
    <label for="inputCity"  class="col-sm-2 control-label">{$LANG.clientareacity}</label>
    <div class="col-sm-10">
      <input type="text" name="city" id="inputCity" value="{$contactcity}" class="form-control" />
    </div>
  </div>

  <div class="form-group st-input">
    <label for="inputState"  class="col-sm-2 control-label">{$LANG.clientareastate}</label>
    <div class="col-sm-6">
      <input type="text" name="state" id="inputState" value="{$contactstate}" class="form-control" />
    </div>
  </div>

  <div class="form-group st-input">
    <label for="inputPostcode"  class="col-sm-2 control-label">{$LANG.clientareapostcode}</label>
    <div class="col-sm-10">
      <input type="text" name="postcode" id="inputPostcode" value="{$contactpostcode}" class="form-control" />
    </div>
  </div>

  <div class="form-group st-input st-input-select">

    <label  class="col-sm-2 control-label" for="country">{$LANG.clientareacountry}</label>
    <div class="col-sm-6">
      {$countriesdropdown}
    </div>
  </div>

  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <div class="checkbox">
        <label>
          <input type="checkbox" name="subaccount" id="inputSubaccountActivate"{if $subaccount} checked{/if} /> {$LANG.subaccountactivatedesc}
        </label>
      </div>
    </div>
  </div>

  <div id="subacct-container" class="{if !$subaccount} hidden{/if}">
    <div class="form-group">
      <div class="col-sm-offset-2 col-sm-10">
      <h5>{$LANG.subaccountpermissions}</h5>
        {foreach $allPermissions as $permission}
              <div class="checkbox">
          <label>
            <input type="checkbox" name="permissions[]" value="{$permission}"{if in_array($permission, $permissions)} checked{/if} />
              {assign var='langPermission' value='subaccountperms'|cat:$permission}{$LANG.$langPermission}
          </label>
        </div>
        {/foreach}
  </div>
</div>
      <div id="newPassword1" class="form-group has-feedback">
        <label for="inputNewPassword1" class="col-sm-2 control-label">{$LANG.newpassword}</label>
        <div class="col-sm-6">
          <input type="password" class="form-control" id="inputNewPassword1" name="password" autocomplete="off" />
          <span class="form-control-feedback glyphicon"></span>
        </div>
      </div>
      <div id="newPassword2" class="form-group has-feedback">
        <label for="inputNewPassword2" class="col-sm-2 control-label">{$LANG.confirmnewpassword}</label>
        <div class="col-sm-6">
          <input type="password" class="form-control" id="inputNewPassword2" name="password2" autocomplete="off" />
          <span class="form-control-feedback glyphicon"></span>
          <div id="inputNewPassword2Msg">
          </div>
        </div>
      </div>
</div>

<div class="form-group">
  <div class="col-sm-offset-2 col-sm-10">
    <h5>{$LANG.clientareacontactsemails}</h5>
      <div class="checkbox">
        <label>
          <input type="checkbox" name="generalemails" id="generalemails" value="1"{if $generalemails} checked{/if} />
          {$LANG.clientareacontactsemailsgeneral}
        </label>
      </div>
      <div class="checkbox">
        <label>
          <input type="checkbox" name="productemails" id="productemails" value="1"{if $productemails} checked{/if} />
          {$LANG.clientareacontactsemailsproduct}
        </label>
    </div>
      <div class="checkbox">
        <label>
          <input type="checkbox" name="domainemails" id="domainemails" value="1"{if $domainemails} checked{/if} />
        {$LANG.clientareacontactsemailsdomain}
        </label>
      </div>
      <div class="checkbox">
        <label>
          <input type="checkbox" name="invoiceemails" id="invoiceemails" value="1"{if $invoiceemails} checked{/if} />
          {$LANG.clientareacontactsemailsinvoice}
        </label>
    </div>
      <div class="checkbox">
        <label>
          <input type="checkbox" name="supportemails" id="supportemails" value="1"{if $supportemails} checked{/if} />
          {$LANG.clientareacontactsemailssupport}
        </label>
    </div>
</div>
</div>
<div class="form-group">
  <div class="col-sm-offset-2 col-sm-10">
    <input class="btn btn-primary" type="submit" name="save" value="{$LANG.clientareasavechanges}" />
  </div>
</div>
</form>
