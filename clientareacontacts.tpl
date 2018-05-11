{* IMPORTANT! FILE WITH CUSTOM CHANGES *}
<link rel="stylesheet" type="text/css" href="{$BASE_PATH_CSS}/dataTables.bootstrap.css">
<script type="text/javascript" charset="utf8" src="{$BASE_PATH_JS}/jquery.dataTables.min.js"></script>
<script type="text/javascript" charset="utf8" src="{$BASE_PATH_JS}/dataTables.bootstrap.min.js"></script>

{if $contactid}
<script type="text/javascript" src="{$BASE_PATH_JS}/StatesDropdown.js"></script>
{include file="$template/pageheader.tpl" title=$LANG.clientareanavcontacts}

{include file="$template/clientareadetailslinks.tpl"}
{if $successful}
{include file="$template/includes/alert.tpl" type="success" msg=$LANG.changessavedsuccessfully textcenter=true}
{/if}

{if $errormessage}
{include file="$template/includes/alert.tpl" type="error" errorshtml=$errormessage}
{/if}

<script type="text/javascript" src="{$BASE_PATH_JS}/StatesDropdown.js"></script>

  <form class="form-horizontal p-2" role="form" method="post" action="{$smarty.server.PHP_SELF}?action=contacts">
    <div class="form-group st-input-select">
      <label for="inputContactID" class="col-sm-2 control-label">{$LANG.clientareachoosecontact}</label>
        <div class="col-sm-10">
      <select name="contactid" id="inputContactID" onchange="submit()" class="form-control">
        {foreach item=contact from=$contacts}
        <option value="{$contact.id}"{if $contact.id eq $contactid} selected="selected"{/if}>{$contact.name} - {$contact.email}</option>
        {/foreach}
        <option value="new">{$LANG.clientareanavaddcontact}</option>
      </select>
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
    <button type="submit" class="btn btn-default">{$LANG.go}</button>
  </div>
</div>
  </form>

<form role="form" method="post" action="{$smarty.server.PHP_SELF}?action=contacts&id={$contactid}" class="form-horizontal p-2">
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
{*
  <div class="form-group">
    <label for="inputAddress2" class="col-sm-2 control-label">{$LANG.clientareaaddress2}</label>
    <div class="col-sm-10">
      <input type="text" name="address2" id="inputAddress2" value="{$contactaddress2}" class="form-control" />
    </div>
  </div>
*}
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

  <div class="form-group st-input">

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
	        {* hostpro start *}
			{if  $permission@value eq 'profile' ||  $permission@value eq 'contacts' || $permission@value eq 'orders' || $permission@value eq 'manageproducts'}
				{continue}
			{/if}
			{* hostpro end *}
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
{if $hasLinkedProvidersEnabled}
    <h3>Linked Accounts</h3>
    {include file="$template/includes/linkedaccounts.tpl" linkContext="linktable" }
{/if}
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
    <a class="btn btn-danger" data-toggle="confirmation" data-btn-ok-label="{lang key='yes'}" data-btn-ok-icon="fa fa-check" data-btn-ok-class="btn-success" data-btn-cancel-label="{lang key='no'}" data-btn-cancel-icon="fa fa-ban" data-btn-cancel-class="btn-default" data-title="{lang key='clientareadeletecontact'}" data-content="{lang key='clientareadeletecontactareyousure'}" data-popout="true" href="clientarea.php?action=contacts&delete=true&id={$contactid}&token={$token}">{lang key='clientareadeletecontact'}</a>

  </div>
</div>
</form>
{else}
{include file="$template/clientareaaddcontact.tpl"}
{/if}

<script type="text/javascript">
    jQuery(document).ready( function ()
    {
        jQuery('.removeAccountLink').click(function (e) {
            e.preventDefault();
            var authUserID = jQuery(this).data('authid');
            swal(
                {
                    title: "Are you sure?",
                    text: "This permanently unlinks the authorized account.",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "Yes, unlink it!",
                    closeOnConfirm: false
                },
                function(){
                    jQuery.post('{routePath('auth-manage-client-delete')}' + authUserID,
                        {
                            'token': '" . generate_token("plain") . "'
                        }).done(function(data) {
                        if (data.status == 'success') {
                            jQuery('#remoteAuth' + authUserID).remove();
                            swal("Unlinked!", data.message, "success");
                        } else {
                            swal("Error!", data.message, "error");
                        }
                    });
                });
        });
    });
</script>
