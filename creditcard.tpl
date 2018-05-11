{if $remotecode}
<div id="frmRemoteCardProcess" class="text-center" align="center">
  {$remotecode}
  <iframe name="ccframe" class="auth3d-area" width="90%" height="600" scrolling="auto" src="about:blank"></iframe>
</div>
<script language="javascript">
jQuery("#frmRemoteCardProcess").find("form:first").attr('target', 'ccframe');
setTimeout("autoSubmitFormByContainer('frmRemoteCardProcess')", 1000);
</script>
{else}
<form id="frmPayment" method="post" action="creditcard.php" role="form">
  <input type="hidden" name="action" value="submit" />
  <input type="hidden" name="invoiceid" value="{$invoiceid}" />
  <div class="row px-1">
    <div class="col-md-12">
      <div id="invoiceIdSummary" class="invoice-summary">
        <h1>{$LANG.invoicenumber}{$invoiceid}</h1>
        <div class="well">
          <div class="row px-1 py-1">
            <div class="col-md-6"><h6>{$LANG.invoicesdescription}</h6></div>
            <div class="col-md-6 text-right"><h6>{$LANG.invoicesamount}</h6></div>
          </div>
          {foreach $invoiceitems as $item}
          <div class="row px-1 pb-1">
            <div class="col-md-6">{$item.description}</div>
            <div class="col-md-6 text-right">{$item.amount}</div>
          </div>
          {/foreach}
          <div class="row px-1 pb-1">
            <div class="col-md-6"><h4>{$LANG.invoicessubtotal}</h4></div>
            <div class="col-md-6 text-right"><h4>{$invoice.subtotal}</h4></div>
          </div>
          {if $invoice.taxrate}
          <div class="row px-1 pb-1">
            <div class="col-md-6">{$invoice.taxrate}% {$invoice.taxname}</div>
            <div class="col-md-6 text-right">{$invoice.tax}</div>
          </div>
          {/if}
          {if $invoice.taxrate2}
          <div class="row px-1 py-1">
            <div class="col-md-6">{$invoice.taxrate2}% {$invoice.taxname2}</div>
            <div class="col-md-6 text-right">{$invoice.tax2}</div>
          </div>
          {/if}
          <div class="row px-1 pb-1">
            <div class="col-md-6">{$LANG.invoicescredit}</div>
            <div class="col-md-6 text-right">{$invoice.credit}</div>
          </div>
          <div class="row px-1 py-1">
            <div class="col-md-6"><h3>{$LANG.invoicestotaldue}</h3></div>
            <div class="col-md-6 text-right"><h3>{$invoice.total}</h3></div>
          </div>
        </div>
        <div class="row px-1 pb-1">
          <div class="col-md-6">{$LANG.paymentstodate}</div>
          <div class="col-md-6 text-right"> {$invoice.amountpaid}</div>
        </div>
        <div class="row px-1 pb-1">
          <div class="col-md-6">{$LANG.balancedue}</div>
          <div class="col-md-6 text-right"> {$balance}</div>
        </div>
      </p>
    </div>
  </div>
</div>
<div class="row">
  <div class="col-md-12">
    <div class="alert alert-warning" role="alert">
      <i class="fa fa-lock"></i> &nbsp; {$LANG.creditcardsecuritynotice}
    </div>
  </div>
</div>
{if $errormessage}
{include file="$template/includes/alert.tpl" type="error" errorshtml=$errormessage}
{/if}
<div class="alert alert-danger text-center gateway-errors hidden"></div>
<div class="row px-1">
  <div class="col-md-6 col-md-offset-3">
    <div class="form-group">
      <div class="radio">
        <label>
          <input type="radio" name="ccinfo" value="new" onclick="showNewCardInputFields()"{if $ccinfo eq "new" || !$cardOnFile} checked{/if} /> {$LANG.creditcardenternewcard}</label>
        </label>
      </div>
      <div class="radio">
        <label>
          <input type="radio" name="ccinfo" value="useexisting" onclick="hideNewCardInputFields()" {if $cardOnFile && $ccinfo neq "new"}checked{elseif !$cardOnFile}disabled{/if} /> {$LANG.creditcarduseexisting}{if $cardOnFile} ({$existingCardType}-{$existingCardLastFour}){/if}
        </label>
      </div>
    </div>
    <div class="form-group{if $userDetailsValidationError} hidden{/if}" id="billingAddressSummary">
      <div class="well well-sm">
        <h4>{$LANG.billingAddress}<span class="pull-right"><button type="button" id="btnEditBillingAddress" onclick="editBillingAddress()" class="btn btn-default btn-sm"{if $cardOnFile} disabled="disabled"{/if}><i class="fa fa-edit"></i></button></span> </h4>
        <p>
          {if $companyname}{$companyname}{else}{$firstname} {$lastname}{/if} <br>
          {$address1}{if $address2}, {$address2}{/if}<br>
          {$city}, {$state}, {$postcode}<br>
          {$countryname}
        </p>
      </div>
    </div>
    <div class="row">
      <div class="col-md-6">
        <div class="form-group cc-billing-address{if !$userDetailsValidationError} hidden{/if}">
          <label for="inputFirstName" class="control-label">{$LANG.clientareafirstname}</label>
          <input type="text" name="firstname" id="inputFirstName" value="{$firstname}" class="form-control" />
        </div>
      </div>
      <div class="col-md-6">
        <div class="form-group cc-billing-address{if !$userDetailsValidationError} hidden{/if}">
          <label for="inputLastName" class="control-label">{$LANG.clientarealastname}</label>
          <input type="text" name="lastname" id="inputLastName" value="{$lastname}" class="form-control" />
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-9">
        <div class="form-group cc-billing-address{if !$userDetailsValidationError} hidden{/if}">
          <label for="inputAddress1" class="control-label">{$LANG.clientareaaddress1}</label>
          <input type="text" name="address1" id="inputAddress1" value="{$address1}" class="form-control" />
        </div>
      </div>
      <div class="col-md-3">
        <div class="form-group cc-billing-address{if !$userDetailsValidationError} hidden{/if}">
          <label for="inputAddress2" class="control-label">{$LANG.clientareaaddress2}</label>
          <input type="text" name="address2" id="inputAddress2" value="{$address2}" class="form-control" />
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-4">
        <div class="form-group cc-billing-address{if !$userDetailsValidationError} hidden{/if}">
          <label for="inputCity" class="control-label">{$LANG.clientareacity}</label>
          <input type="text" name="city" id="inputCity" value="{$city}" class="form-control" />
        </div>
      </div>
      <div class="col-md-4">
        <div class="form-group cc-billing-address{if !$userDetailsValidationError} hidden{/if}">
          <label for="inputState" class="control-label">{$LANG.clientareastate}</label>
          <input type="text" name="state" id="inputState" value="{$state}" class="form-control" />
        </div>
      </div>
      <div class="col-md-4">
        <div class="form-group cc-billing-address{if !$userDetailsValidationError} hidden{/if}">
          <label for="inputPostcode" class="control-label">{$LANG.clientareapostcode}</label>
          <input type="text" name="postcode" id="inputPostcode" value="{$postcode}" class="form-control" />
        </div>
      </div>
    </div>
    <div class="form-group cc-billing-address{if !$userDetailsValidationError} hidden{/if}">
      <label for="inputCountry" class="control-label">{$LANG.clientareacountry}</label>
      {$countriesdropdown}
    </div>
    <div class="form-group cc-billing-address{if !$userDetailsValidationError} hidden{/if}">
      <label for="inputPhone" class="control-label">{$LANG.clientareaphonenumber}</label>
      <input type="text" name="phonenumber" id="inputPhone" value="{$phonenumber}" class="form-control" />
    </div>
    <div class="row">
    <div class="col-md-12">
    <div class="form-group cc-details{if !$addingNewCard} hidden{/if}">
      <label for="cctype" class="control-label">{$LANG.creditcardcardtype}</label>
      <select name="cctype" id="cctype" class="form-control newccinfo">
        {foreach from=$acceptedcctypes item=type}
        <option{if $cctype eq $type} selected{/if}>
        {$type}
      </option>
      {/foreach}
    </select>
  </div>
</div>
    <div class="col-md-6">
      <div class="form-group cc-details{if !$addingNewCard} hidden{/if}">
        <label for="inputCardNumber" class="control-label">{$LANG.creditcardcardnumber}</label>
        <input type="tel" name="ccnumber" id="inputCardNumber" size="30" value="{if $ccnumber}{$ccnumber}{/if}" autocomplete="off" class="form-control newccinfo" />
      </div>
    </div>
    <div class="col-md-6">
      <div class="form-group">
        <label for="cctype" class="control-label"><a href="#a" data-toggle="popover" data-content="<img src='{$BASE_PATH_IMG}/ccv.gif' width='210' />">{$LANG.creditcardcvvnumber}</a></label>
        <input type="number" name="cccvv" id="inputCardCvv" value="{$cccvv}" autocomplete="off" class="form-control input-inline input-inline-100" />
      </div>
    </div>
</div>
    {if $showccissuestart}
      <div class="form-group cc-details{if !$addingNewCard} hidden{/if}">
        <div class="row">
          <div class="col-md-6">
            <label for="inputCardStart" class="control-label">{$LANG.creditcardcardstart}</label>
            <select name="ccstartmonth" id="inputCardStart" class="form-control select-inline">
              {foreach from=$months item=month}
              <option{if $ccstartmonth eq $month} selected{/if}>{$month}</option>
              {/foreach}
            </select>
          </div>
          <div class="col-md-6">
            <label class="control-label">&nbsp;</label>
            <select name="ccstartyear" id="inputCardStartYear" class="form-control select-inline">
              {foreach from=$startyears item=year}
              <option{if $ccstartyear eq $year} selected{/if}>{$year}</option>
              {/foreach}
            </select>
          </div>
        </div>
      </div>
    {/if}
      <div class="form-group cc-details{if !$addingNewCard} hidden{/if}">
            <div class="row">
          <div class="col-md-6">
            <label for="inputCardExpiry" class="control-label">{$LANG.creditcardcardexpires}</label>
            <select name="ccexpirymonth" id="inputCardExpiry" class="form-control select-inline">
              {foreach from=$months item=month}
              <option{if $ccexpirymonth eq $month} selected{/if}>{$month}</option>
              {/foreach}
            </select>
          </div>
          <div class="col-md-6">
            <label class="control-label">&nbsp;</label>
            <select name="ccexpiryyear" id="inputCardExpiryYear" class="form-control select-inline">
              {foreach from=$expiryyears item=year}
              <option{if $ccexpiryyear eq $year} selected{/if}>{$year}</option>
              {/foreach}
            </select>
          </div>
      </div>
    </div>
    {if $showccissuestart}
    <div class="col-md-6">
    <div class="form-group cc-details{if !$addingNewCard} hidden{/if}">
        <label for="inputIssueNum" class="control-label">{$LANG.creditcardcardissuenum}</label>
        <input type="number" name="ccissuenum" id="inputIssueNum" value="{$ccissuenum}" class="form-control" />
      </div>
    </div>
    {/if}
  {if $shownostore}
  <div class="form-group cc-details{if !$addingNewCard} hidden{/if}">
    <div class="checkbox">
      <label>
        <input type="checkbox" name="nostore" id="inputNoStore"> <small>{$LANG.creditcardnostore}</small>
      </label>
    </div>
  </div>
  {/if}
  <div class="form-group">
  <button type="submit" class="btn btn-primary btn-block btn-lg" id="btnSubmit" value="{$LANG.submitpayment}">
    <span class="pay-text">{$LANG.submitpayment}</span>
    <span class="click-text hidden">{$LANG.pleasewait}</span>
</button>
  </div>
</div>
</div>
</form>
{/if}
