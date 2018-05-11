{include file="$template/pageheader.tpl" title=$LANG.clientareanavchangepw}
{include file="$template/clientareadetailslinks.tpl"}

{if $remoteupdatecode}
    <div align="center">
        {$remoteupdatecode}
    </div>
{else}

    <div class="credit-card form-group p-2">
    <div class="col-md-1">
        <div class="card-icon">
            <b class="fa fa-4x
            {if $cardtype eq "American Express"}
                fa-cc-amex logo-amex
            {elseif $cardtype eq "Visa"}
                fa-cc-visa logo-visa
            {elseif $cardtype eq "MasterCard"}
                fa-cc-mastercard logo-mastercard
            {elseif $cardtype eq "Discover"}
                fa-cc-discover logo-discover
            {else}
                fa-credit-card
            {/if}">&nbsp;</b>
        </div>
</div>
<div class="col-md-11">
        <div class="card-type">
            {if $cardtype neq "American Express" && $cardtype neq "Visa" && $cardtype neq "MasterCard" && $cardtype neq "Discover"}
                {$cardtype}
            {/if}
        </div>
        <div class="card-number">
            {if $cardlastfour}xxxx xxxx xxxx {$cardlastfour}{else}{$LANG.creditcardnonestored}{/if}
        </div>
        <div class="card-start">
            {if $cardstart}Start: {$cardstart}{/if}
        </div>
        <div class="card-expiry">
            {if $cardexp}Expires: {$cardexp}{/if}
        </div>
        <div class="end"></div>
    </div>
</div>
    {if $allowcustomerdelete && $cardtype}
        <form method="post" action="clientarea.php?action=creditcard">
            <input type="hidden" name="remove" value="1" />
            <button type="submit" class="btn btn-link" data-toggle="confirmation" data-btn-ok-label="{lang key='yes'}" data-btn-ok-icon="fa fa-check" data-btn-ok-class="btn-success" data-btn-cancel-label="{lang key='no'}" data-btn-cancel-icon="fa fa-ban" data-btn-cancel-class="btn-default" data-title="{lang key='creditcarddelete'}" data-content="{lang key='creditCard.removeDescription'}" data-popout="true">
                    {$LANG.creditcarddelete}
                </button>
        </form>
    {/if}

<hr>

    {if $successful}
        {include file="$template/includes/alert.tpl" type="success" msg=$LANG.changessavedsuccessfully textcenter=true}
    {/if}

    {if $errormessage}
        {include file="$template/includes/alert.tpl" type="error" errorshtml=$errormessage}
    {/if}


    <form id="frmNewCc" class="form-horizontal" role="form" method="post" action="{$smarty.server.PHP_SELF}?action=creditcard">
        <div class="alert alert-danger text-center gateway-errors hidden"></div>

        <div class="form-group">
            <label for="inputCardType" class="col-sm-3 control-label">{$LANG.creditcardcardtype}</label>
            <div class="col-sm-4">
                <select name="cctype" id="inputCardType" class="form-control">
                    {foreach from=$acceptedcctypes item=fieldcardtype}
                    <option {if $fieldcardtype eq $cardtype}selected{/if}>{$fieldcardtype}</option>
                    {/foreach}
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="inputCardNumber" class="col-sm-3 control-label">{$LANG.creditcardcardnumber}</label>
            <div class="col-sm-6">
                <input type="tel" class="form-control" id="inputCardNumber" name="ccnumber" autocomplete="off" />
            </div>
        </div>
        {if $showccissuestart}
            <div class="form-group">
                <label for="inputCardStart" class="col-sm-3 control-label">{$LANG.creditcardcardstart}</label>
                <div class="col-sm-6">
                    <select name="ccstartmonth" id="inputCardStart" class="form-control select-inline">
                        {foreach from=$months item=month}
                        <option{if $ccstartmonth eq $month} selected{/if}>{$month}</option>
                        {/foreach}
                    </select>
                    <select name="ccstartyear" class="form-control select-inline">
                        {foreach from=$startyears item=year}
                        <option{if $ccstartyear eq $year} selected{/if}>{$year}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
        {/if}
        <div class="form-group">
            <label for="inputCardExpiry" class="col-sm-3 control-label">{$LANG.creditcardcardexpires}</label>
            <div class="col-sm-6">
            <div class="row">
            <div class="col-md-6">
                <select name="ccexpirymonth" id="inputCardExpiry" class="form-control select-inline">
                    {foreach from=$months item=month}
                    <option{if $ccstartmonth eq $month} selected{/if}>{$month}</option>
                    {/foreach}
                </select>
            </div>
              <div class="col-md-6">
                <select name="ccexpiryyear" class="form-control select-inline">
                    {foreach from=$expiryyears item=year}
                    <option{if $ccstartyear eq $year} selected{/if}>{$year}</option>
                    {/foreach}
                </select>
                </div>
            </div>
        </div>
        </div>
        {if $showccissuestart}
            <div class="form-group">
                <label for="inputCardIssue" class="col-sm-4 col-xs-12 control-label">{$LANG.creditcardcardissuenum}</label>
                <div class="col-sm-2 col-xs-4">
                    <input type="tel" class="form-control" id="inputCardIssue" name="ccissuenum" autocomplete="off" />
                </div>
            </div>
        {/if}
        <div class="form-group">
            <label for="inputCardCVV" class="col-sm-3 col-xs-12 control-label">{$LANG.creditcardcvvnumber}</label>
            <div class="col-sm-3">
                <input type="tel" class="form-control input-inline input-inline-100" id="inputCardCVV" name="cardcvv" autocomplete="off" />
                <button type="button" class="btn btn-link" data-toggle="popover" data-placement="bottom" data-content="<img src='{$BASE_PATH_IMG}/ccv.gif' width='210' />">
                <span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span> {$LANG.creditcardcvvwhere}
                </button>
            </div>
        </div>
	 <div class="row m-1">
	  <div class="col-md-6 col-md-offset-3">
        <div class="form-group">
                <input class="btn btn-lg btn-primary" id="btnSubmitNewCard" type="submit" name="submit" value="{$LANG.clientareasavechanges}" />
		<input class="btn btn-lg btn-link" type="reset" value="{$LANG.cancel}" />
        </div>
</div>
</div>
    </form>
{/if}
            </div>
