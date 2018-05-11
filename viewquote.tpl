<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="{$charset}" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$companyname} - {$LANG.quotenumber}{$id}</title>
    <!-- Bootstrap -->
    <link href="{$BASE_PATH_CSS}/bootstrap.min.css" rel="stylesheet">

  {if $LANG.locale == 'ar_AR' || $LANG.locale == 'fa_IR' || $LANG.locale == 'he_IL'}
    <link href="{$WEB_ROOT}/templates/{$template}/assets/css/bootstrap-rtl.min.css" rel="stylesheet">
    <link href="{$WEB_ROOT}/templates/{$template}/assets/css/style-rtl.css" rel="stylesheet">
  {/if}

    <link href="{$BASE_PATH_CSS}/font-awesome.min.css" rel="stylesheet">
    <!-- Google Font -->
    <link href='https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,200,600' rel='stylesheet' type='text/css'>
    <!-- Styling -->
    <link href="templates/{$template}/assets/css/invoice-clean.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        {if $invalidQuoteIdRequested}
        {include file="$template/includes/panel.tpl" type="danger" headerTitle=$LANG.error bodyContent=$LANG.invoiceserror bodyTextCenter=true}
        {else}
        <div class="invoice-container">
            <div class="row">
                <div class="col-md-10 col-md-offset-1">
                    <div class="row">
                        <div class="col-sm-8">
                            {if $logo}
                            <div class="logo"><img src="{$logo}" title="{$companyname}" /></div>
                            {else}
                            <h2>{$companyname}</h2>
                            {/if}
                        </div>
                        <div class="col-sm-4">
                            <div class="invoice-status text-right">
                                {if $stage eq "Delivered"}
                                <span class="unpaid">{$LANG.quotestagedelivered}</span>
                                {elseif $stage eq "Accepted"}
                                <span class="paid">{$LANG.quotestageaccepted}</span>
                                {elseif $stage eq "On Hold"}
                                <span class="refunded">{$LANG.quotestageonhold}</span>
                                {elseif $stage eq "Lost"}
                                <span class="cancelled">{$LANG.quotestagelost}</span>
                                {elseif $stage eq "Dead"}
                                <span class="collections">{$LANG.quotestagedead}</span>
                                {/if}
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-8"><h3>{$LANG.quotenumber}{$id}</h3></div>
                        <div class="col-sm-4 text-right">
                            {if $stage eq "Delivered" || $stage eq "On Hold"}
                            <div class="payment-btn-container">
                                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#acceptQuoteModal"><i class="fa fa-check-circle"></i> {$LANG.quoteacceptbtn}</button>
                            </div>
                            {/if}
                        </div>
                    </div>
                    <hr>
                    {if $agreetosrequired}
                    {include file="$template/includes/panel.tpl" type="flat" headerTitle=$LANG.error bodyContent=$LANG.ordererroraccepttos bodyTextCenter=true}
                    {/if}
                    <div class="row">
                        <div class="col-md-3 col-sm-6">
                            <h5>{$LANG.quoterecipient}:</h5>
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
                        <div class="col-md-3 col-sm-6">
                            <h5>{$LANG.invoicespayto}:</h5>
                            <address>
                                {$payto}
                            </address>
                        </div>
                        <div class="col-md-3 col-sm-6">
                           <h5>{$LANG.quotedatecreated}:</h5>
                                <p>{$datecreated}</p>
                            </span>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <h5>{$LANG.quotevaliduntil}:</h5>
                                <p>{$validuntil}</p>
                        </div>
                    </div>
                    <br />
                    {if $proposal}
                    {include file="$template/includes/panel.tpl" type="flat" headerTitle=$LANG.quoteproposal bodyContent=$proposal}
                    {/if}
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <td>{$LANG.invoicesdescription}</td>
                                    <td>{$LANG.quotediscountheading}</td>
                                    <td class="text-right">{$LANG.invoicesamount}</td>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach from=$quoteitems item=item}
                                <tr>
                                    <td>{$item.description}{if $item.taxed} *{/if}</td>
                                    <td>{if $item.discountpc > 0}{$item.discount} ({$item.discountpc}%){else} - {/if}</td>
                                    <td class="text-right">{$item.amount}</td>
                                </tr>
                                {/foreach}
                                <tr class="active">
                                    <td colspan="2">{$LANG.invoicessubtotal}</td>
                                    <td class="text-right">{$subtotal}</td>
                                </tr>
                                {if $taxrate}
                                <tr class="active">
                                    <td colspan="2">{$taxrate}% {$taxname}</td>
                                    <td class="text-right">{$tax}</td>
                                </tr>
                                {/if}
                                {if $taxrate2}
                                <tr class="active">
                                    <td colspan="2">{$taxrate2}% {$taxname2}</td>
                                    <td class="text-right">{$tax2}</td>
                                </tr>
                                {/if}
                                <tr>
                                    <td colspan="2">{$LANG.quotelinetotal}</td>
                                    <td class="text-right">{$total}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    {if $notes}
                    {include file="$template/includes/panel.tpl" type="flat" headerTitle=$LANG.invoicesnotes bodyContent=$notes}
                    {/if}
                    {if $taxrate}
                    <p>* {$LANG.invoicestaxindicator}</p>
                    {/if}
                    {/if}
                </div>
                <form method="post" action="viewquote.php?id={$quoteid}&amp;action=accept">
                    <div class="modal fade" id="acceptQuoteModal">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title">{$LANG.quoteacceptbtn}</h4>
                                </div>
                                <div class="modal-body">
                                    <p>{$LANG.quoteacceptagreetos}</p>
                                    <p>
                                        <label class="checkbox-inline">
                                            <input type="checkbox" name="agreetos" />
                                            {$LANG.ordertosagreement} <a href="{$tosurl}" target="_blank">{$LANG.ordertos}</a>
                                        </label>
                                    </p>
                                    <small>{$LANG.quoteacceptcontractwarning}</small>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">{$LANG.cancel}</button>
                                    <button type="submit" class="btn btn-primary">{$LANG.quoteacceptbtn}</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <p class="text-center hidden-print">
            <a class="btn btn-link" href="clientarea.php">{$LANG.invoicesbacktoclientarea}</a>
            <a href="javascript:window.print()" class="btn btn-link"><i class="fa fa-print"></i> {$LANG.print}</a>
            <a href="dl.php?type=q&amp;id={$quoteid}" class="btn btn-link"><i class="fa fa-arrow-down"></i> {$LANG.invoicesdownload}</a>
        </p>
    </div>
    <!-- Javascript -->
    <script src="{$BASE_PATH_JS}/jquery.min.js"></script>
    <script src="{$BASE_PATH_JS}/bootstrap.min.js"></script>
</body>
</html>
