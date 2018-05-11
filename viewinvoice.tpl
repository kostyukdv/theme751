{* IMPORTANT! FILE WITH CUSTOM CHANGES *}
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="{$charset}" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$companyname} - {$pagetitle}</title>
    <!-- Bootstrap -->
    <link href="{$BASE_PATH_CSS}/bootstrap.min.css" rel="stylesheet">

  {if $LANG.locale == 'ar_AR' || $LANG.locale == 'fa_IR' || $LANG.locale == 'he_IL'}
    <link href="{$WEB_ROOT}/templates/{$template}/assets/css/bootstrap-rtl.min.css" rel="stylesheet">
    <link href="{$WEB_ROOT}/templates/{$template}/assets/css/style-rtl.css" rel="stylesheet">
  {/if}

    <link href="{$BASE_PATH_CSS}/font-awesome.min.css" rel="stylesheet">
    
    <script type="text/javascript" src="{$BASE_PATH_JS}/jquery.min.js"></script>
    <!-- Google Font -->
    <link href='https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,200,600' rel='stylesheet' type='text/css'>
    <!-- Styling -->
    <link href="templates/{$template}/assets/css/invoice-clean.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        {if $invalidInvoiceIdRequested}
        {include file="$template/includes/panel.tpl" type="danger" headerTitle=$LANG.error bodyContent=$LANG.invoiceserror bodyTextCenter=true}
        {else}
        <div class="invoice-container">
            <div class="row">
                <div class="col-md-10 col-md-offset-1">
                    <div class="row">
                        <div class="col-sm-8">
                            {* hostpro start *}    
	                        <div class="logo"><img src="templates/{$template}/img/logo.png" title="{$companyname}" /></div>
	                        {* hostpro end *}

                        </div>
                        <div class="col-sm-4">
                        <div class="invoice-status text-right">
                        		{if $status eq "Draft"}
                           		<span class="draft">{$LANG.invoicesdraft}</span>
                   		        {elseif $status eq "Unpaid"}
                                <span class="unpaid">{$LANG.invoicesunpaid}</span>
                                {elseif $status eq "Paid"}
                                <span class="paid">{$LANG.invoicespaid}</span>
                                {elseif $status eq "Refunded"}
                                <span class="refunded">{$LANG.invoicesrefunded}</span>
                                {elseif $status eq "Cancelled"}
                                <span class="cancelled">{$LANG.invoicescancelled}</span>
                                {elseif $status eq "Collections"}
                                <span class="collections">{$LANG.invoicescollections}</span>
                                {elseif $status eq "Payment Pending"}
                                <span class="paid">{$LANG.invoicesPaymentPending}</span>
                                {/if}
                            </div>
                        </div>
                    </div>

                    <div class="row">
                    <div class="col-md-8">
                    <h3>{$pagetitle}</h3>
                    </div>

                    <div class="col-md-4">
                            {if $status eq "Unpaid"}
                            <div class="payment-btn-container text-right">
                                {$paymentbutton}
                            </div>
                            {/if}
                    </div>
                    </div>

                    <hr>
                    {if $paymentSuccessAwaitingNotification}
                        {include file="$template/includes/panel.tpl" type="success" headerTitle=$LANG.success bodyContent=$LANG.invoicePaymentSuccessAwaitingNotify bodyTextCenter=true}
                    {elseif $paymentSuccess}
                        {include file="$template/includes/panel.tpl" type="success" headerTitle=$LANG.success bodyContent=$LANG.invoicepaymentsuccessconfirmation bodyTextCenter=true}
                    {elseif $pendingReview}
                        {include file="$template/includes/panel.tpl" type="info" headerTitle=$LANG.success bodyContent=$LANG.invoicepaymentpendingreview bodyTextCenter=true}
                    {elseif $paymentFailed}
                        {include file="$template/includes/panel.tpl" type="danger" headerTitle=$LANG.error bodyContent=$LANG.invoicepaymentfailedconfirmation bodyTextCenter=true}
                    {elseif $offlineReview}
                        {include file="$template/includes/panel.tpl" type="info" headerTitle=$LANG.success bodyContent=$LANG.invoiceofflinepaid bodyTextCenter=true}
                    {/if}
                    <div class="row">
                        <div class="col-md-3 col-sm-6">
                         <h5>{$LANG.invoicesinvoicedto}:</h5>
                         <address>
                            {if $clientsdetails.companyname}{$clientsdetails.companyname}<br>{/if}
                            {$clientsdetails.firstname} {$clientsdetails.lastname}<br>
                            {$clientsdetails.address1}, {$clientsdetails.address2}<br>
                            {$clientsdetails.city}, {$clientsdetails.state}, {$clientsdetails.postcode}<br>
                            {$clientsdetails.country}
                            {if $customfields}
                            <br><br>
                            {foreach from=$customfields item=customfield}
                            {$customfield.fieldname}: {$customfield.value}<br>
                            {/foreach}
                            {/if}
                        </address>
                    </div>
                    {* hostpro start *} 
                    {*
                    <div class="col-md-3 col-sm-6">
                        <h5>{$LANG.invoicespayto}:</h5>
                        <address>
                            {$payto}
                        </address>
                    </div>
                    *}
                    {* hostpro end *} 
                    <div class="col-md-3 col-sm-6">
                        <h5>{$LANG.invoicesdatecreated}:</h5>
                        <p>{$date}</p>

                         {if $status eq "Unpaid" || $status eq "Draft"}
                        <h5>{$LANG.invoicesdatedue}:</h5>
                        <p>{$datedue}</p>
                            {/if}

                    </div>
                    <div class="col-md-3 col-sm-6">
                     <h5>{$LANG.paymentmethod}:</h5>
                     {if $status eq "Unpaid" && $allowchangegateway}
                     <form method="post" action="{$smarty.server.PHP_SELF}?id={$invoiceid}" class="form-inline">
                        {$gatewaydropdown}
                    </form>
                    {else}
                    {$paymentmethod}
                    {/if}
                </div>
            </div>
            {if $manualapplycredit}
            <div class="panel panel-flat">
                <div class="panel-heading">
                    <h3 class="panel-title">{$LANG.invoiceaddcreditapply}</h3>
                </div>
                <div class="panel-body">
                    <form method="post" action="{$smarty.server.PHP_SELF}?id={$invoiceid}">
                        <input type="hidden" name="applycredit" value="true" />
                        {$LANG.invoiceaddcreditdesc1} {$totalcredit}. {$LANG.invoiceaddcreditdesc2}. {$LANG.invoiceaddcreditamount}:
                        <div class="row">
                            <div class="col-xs-8 col-xs-offset-2 col-sm-4 col-sm-offset-4">
                                <div class="input-group">
                                    <input type="text" name="creditamount" value="{$creditamount}" class="form-control" />
                                    <span class="input-group-btn">
                                        <input type="submit" value="{$LANG.invoiceaddcreditapply}" class="btn btn-success" />
                                    </span>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            {/if}
            {if $notes}
            {include file="$template/includes/panel.tpl" type="info" headerTitle=$LANG.invoicesnotes bodyContent=$notes}
            {/if}
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <td>{$LANG.invoicesdescription}</td>
                            <td class="text-right">{$LANG.invoicesamount}</td>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$invoiceitems item=item}
                        <tr>
                            <td>{$item.description|replace:'(00/00/0000 - 30/12/1999)':'-- Тестовый период'}{if $item.taxed eq "true"} *{/if}</td>
                            <td class="text-right">{$item.amount}</td>
                        </tr>
                        {/foreach}
                        <tr class="active">
                            <td>{$LANG.invoicessubtotal}</td>
                            <td class="text-right">{$subtotal}</td>
                        </tr>
                        {if $taxrate}
                        <tr class="active">
                            <td>{$taxrate}% {$taxname}</td>
                            <td class="text-right">{$tax}</td>
                        </tr>
                        {/if}
                        {if $taxrate2}
                        <tr class="active">
                            <td>{$taxrate2}% {$taxname2}</td>
                            <td class="text-right">{$tax2}</td>
                        </tr>
                        {/if}
                        <tr class="active">
                            <td>{$LANG.invoicescredit}</td>
                            <td class="text-right">{$credit}</td>
                        </tr>
                        <tr>
                            <td><h4>{$LANG.invoicestotal}</h4></td>
                            <td class="text-right"><h4>{$total}</h4></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            {if $taxrate}
            <p>* {$LANG.invoicestaxindicator}</p>
            {/if}
            <div class="transactions-container">
                <div class="table-responsive">
                    <table class="table table-condensed">
                        <thead>
                            <tr>
                                <td>{$LANG.invoicestransdate}</td>
                                <td>{$LANG.invoicestransgateway}</td>
                                <td>{$LANG.invoicestransid}</td>
                                <td class="text-right">{$LANG.invoicestransamount}</td>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach from=$transactions item=transaction}
                            <tr>
                                <td>{$transaction.date}</td>
                                <td>{$transaction.gateway}</td>
                                <td>{$transaction.transid}</td>
                                <td class="text-right">{$transaction.amount}</td>
                            </tr>
                            {foreachelse}
                            <tr>
                                <td colspan="4">{$LANG.invoicestransnonefound}</td>
                            </tr>
                            {/foreach}
                            <tr>
                                <td colspan="3">{$LANG.invoicesbalance}</td>
                                <td class="text-right">{$balance}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            {/if}
        </div>
    </div>
</div>
<p class="text-center hidden-print">
<a class="btn btn-link" href="clientarea.php">{$LANG.invoicesbacktoclientarea}</a>
<a href="javascript:window.print()" class="btn btn-link"><i class="fa fa-print"></i> {$LANG.print}</a>
<a href="dl.php?type=i&amp;id={$invoiceid}" class="btn btn-link"><i class="fa fa-arrow-down"></i> {$LANG.invoicesdownload}</a>
</p>
</div>

{* uniweb start *}
{if (!empty($hostprodata_analytics.invoice.analyticsItemsGA))}
<script type="text/javascript">
        dataLayer = [{$hostprodata_analytics.invoice.analyticsItemsGA|@json_encode}];
</script>

<script>
    var yaParams = {$hostprodata_analytics.invoice.analyticsItemsYA|@json_encode};
    var orderId = {$hostprodata_analytics.invoice.order_id};
    {literal}
    window.onload = function() {
        yaCounter11441773.reachGoal('Оплаченные заказы', {order_id: orderId});
    }
    {/literal}
</script>

{literal}
<!-- Google Tag Manager -->
<noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-MZ24SQ"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-MZ24SQ');</script>
<!-- End Google Tag Manager -->
{/literal}
{/if}
<script>
$(document).ready(function(){
    var allowedGateways = [{foreach from=$allowedGateways item=method}"{$method}",{/foreach}];
    var currentGateway = $("select[name=gateway]").val();

    $("select[name=gateway] option").each(function(){
        if (allowedGateways.indexOf($(this).val()) == -1) {
            $(this).remove();
        }
    });
    
    if ($("select[name=gateway]").val() != currentGateway) {
        $("select[name=gateway]").val("{$defaultGateway}").trigger("change");
    }
});
</script>
{if (!empty($newAmountInUah))}
<script>
$(document).ready(function(){
	if ($("select[name=gateway]").val() == 'privat24') {
		$('input[name="amt"]').val("{$newAmountInUah}");
	}
});
</script>
{/if}
{* uniweb end *}

</body>
</html>
