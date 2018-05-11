{* IMPORTANT! FILE WITH CUSTOM CHANGES *}
<h3 class="page-header"><span aria-hidden="true" class="icon icon-wallet"></span> {$LANG.addfunds1} <i class="fa fa-info-circle animated bounce show-info"></i>
</h3>
<blockquote class="page-information">
	<p>{$LANG.addfundsdescription}</p>
</blockquote> 
{if $addfundsdisabled}
<div class="alert alert-danger">
	<p>{$LANG.clientareaaddfundsdisabled}</p>
</div>
{else}
{if $notallowed || $errormessage}<div class="alert alert-danger">
<p>{$LANG.clientareaerrors}</p>
<ul>
	<li>{if $notallowed}{$LANG.clientareaaddfundsnotallowed}{else}{$errormessage}{/if}</li>
</ul>
</div>{/if}
<div class="row px-1 pt-1">
	<div class="col-md-4">
		<div class="info-box  bg-info  text-white">
			<div class="info-icon bg-info-dark">

				<span aria-hidden="true" class="icon icon-arrow-down"></span>
			</div>
			<div class="info-details">
				<h4>{$LANG.addfundsminimum}</h4>
				<p><span class="badge">{$minimumamount}</span></p>
			</div>
		</div>
	</div>
	<div class="col-md-4">
		<div class="info-box  bg-warn  text-white">
			<div class="info-icon bg-warn-dark">
				<span aria-hidden="true" class="icon icon-arrow-up"></span>
			</div>
			<div class="info-details">
				<h4>{$LANG.addfundsmaximum}</h4>
				<p><span class="badge">{$maximumamount}</span></p>
			</div>
		</div>
	</div>
	<div class="col-md-4">
		<div class="info-box  bg-inactive  text-white">
			<div class="info-icon bg-inactive-dark">
				<span aria-hidden="true" class="icon icon-chart"></span>
			</div>
			<div class="info-details">
				<h4>{$LANG.addfundsmaximumbalance}</h4>
				<p><span class="badge">{$maximumbalance}</span></p>
			</div>
		</div>
	</div>
</div>
<hr>
<div class="row">
<div class="col-md-6 col-md-offset-3">
<form method="post" action="{$smarty.server.PHP_SELF}?action=addfunds">
	<div class="row">
		<div class="col-md-12">
			<div class="form-group">
				<label class="control-label" for="currentbalance">{$LANG.statscreditbalance}</label>
				<input class="form-control" name="currentbalance" type="text" placeholder="{$clientsstats.creditbalance}" readonly>
				<p class="help-block">{$LANG.addfundsnonrefundable}</p>
			</div>
		</div>
		<div class="col-md-12">
			<div class="form-group">
				<label class="control-label" for="amount">{$LANG.addfundsamount}:</label>
				<input type="text" class="form-control"  name="amount" id="amount" value="{$amount}" />
			</div>
		</div>
		<div class="col-md-12">
			<div class="form-group">
				<label class="control-label" for="paymentmethod">{$LANG.orderpaymentmethod}:</label>
				<select name="paymentmethod" class="form-control" id="paymentmethod">
					{*foreach from=$gateways item=gateway}
					<option value="{$gateway.sysname}">{$gateway.name}</option>
					{/foreach*}
					{* uniweb start *}
					{foreach from=$customGateways item=gateway}
                    <option value="{$gateway.sysname}">{$gateway.name}</option>
                	{/foreach}
                	{* uniweb end *}
				</select>
			</div>
		</div>
	</div>
	<input type="submit" value="{$LANG.addfunds1}" class="btn btn-lg btn-primary btn-block" />
</form>
</div>
</div>
{/if}
