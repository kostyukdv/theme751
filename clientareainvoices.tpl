{* IMPORTANT! FILE WITH CUSTOM CHANGES *}

{include file="$template/pageheader.tpl" title=$LANG.invoices desc=$LANG.invoicesintro icon=drawer}

{* uniweb start *}

{*include file="$template/includes/tablelist.tpl" tableName="InvoicesList" filterColumn="4" noSortColumns="5"*}

{include file="$template/includes/tablelist.tpl" tableName="InvoicesList" filterColumn="5" noSortColumns="6"}

{* uniweb end *}

<div class="alert alert-info {*mb-0*}">

{$LANG.invoicesoutstandingbalance}: {$totalbalance}

{if $masspay}

<div class="pull-right flip"><a href="clientarea.php?action=masspay&all=true" class="btn btn-link"><span class="glyphicon glyphicon-ok-circle"></span> {$LANG.masspayall}</a></div>

{/if}

</div>



<script type="text/javascript">

    jQuery(document).ready( function ()

    {

        var table = jQuery('#tableInvoicesList').removeClass('hidden').DataTable();

        {if $orderby == 'default'}

            table.order([4, 'desc'], [2, 'asc']);

        {elseif $orderby == 'invoicenum'}

            table.order(0, '{$sort}');

        {elseif $orderby == 'date'}

            table.order(1, '{$sort}');

        {elseif $orderby == 'duedate'}

            table.order(2, '{$sort}');

        {elseif $orderby == 'total'}

            table.order(3, '{$sort}');

        {elseif $orderby == 'status'}

            table.order(4, '{$sort}');

        {/if}

        table.draw();

        jQuery('#tableLoading').addClass('hidden');

    });

</script>



<div class="table-container clearfix">

    <div class="panel panel-default panel-datatable">

    <div class="panel-heading clearfix"> {include file="$template/includes/sidebar.tpl" sidebar=$primarySidebar}</div>

    <table id="tableInvoicesList" class="table table-list hidden">

        <thead>

            <tr>

                <th>{$LANG.invoicestitle}</th>

                {* uniweb start *}

		        <th style="width: 250px;" class="invoice-description" >Описание</th>

		        {* uniweb end *}

                <th class="hidden-sm hidden-xs">{$LANG.invoicesdatecreated}</th>

                <th class="hidden-xs">{$LANG.invoicesdatedue}</th>

                <th style="width: 90px;" class="hidden-sm hidden-xs">{$LANG.invoicestotal}</th>

                <th>{$LANG.invoicesstatus}</th>

                <th class="text-center hidden-sm hidden-xs" style="width: 190px;">{$LANG.actions}</th>

            </tr>

        </thead>

        <tbody>

            {foreach key=num item=invoice from=$invoices}

                <tr>

                    {* uniweb start *}

                    <td><a href="viewinvoice.php?id={$invoice.id}" title="{'<br/>'|implode:$invoicesDescriptions[$invoice.id]}" class="invoice-desc">{$invoice.invoicenum}</a>

                    {* uniweb end *}



                    <ul class="cell-inner-list visible-sm visible-xs small">

                    <li><span class="item-title">{$LANG.invoicestotal}: </span>{$invoice.total}</li>

                    <li><span class="item-title">{$LANG.invoicesdatecreated}: </span>{$invoice.datecreated}</li>

                    <li class="hidden-sm"><span class="item-title">{$LANG.invoicesdatedue}: </span>{$invoice.datedue}</li>

                    </ul>

                    </td>

					{* uniweb start *}

				     <td>{"<br/>"|implode:$invoicesDescriptions[$invoice.id]|regex_replace:"/\(\d+\/\d+\/\d+ - \d+\/\d+\/\d+\)/":""}</td>

				    {* uniweb end *}

                    <td class="hidden-sm hidden-xs"><span class="hidden">{$invoice.normalisedDateCreated}</span>{$invoice.datecreated}</td>

                    <td class="hidden-xs"><span class="hidden">{$invoice.normalisedDateDue}</span>{$invoice.datedue}</td>

                    <td data-order="{$invoice.totalnum}" class="hidden-sm hidden-xs">{$invoice.total}</td>

                     <td class="hidden-sm hidden-xs"><span class="label label-{$invoice.statusClass}">{$invoice.status}</span></td>  

                    <td class="text-left" style="width: 190px;">

                    {* uniweb start *}                    

                        <a href="viewinvoice.php?id={$invoice.id}" title="{'<br/>'|implode:$invoicesDescriptions[$invoice.id]}" class="" >

                            <i class="fa fa-file-text-o" aria-hidden="true"></i> {$LANG.invoiceopen}

                        </a>

                        {if in_array($invoice.id, $isInvoisesRemove)}

                        <span style="color: #DDDDDD;margin: 0 5px;">|</span> <a class="text-danger" style="display: inline;cursor: pointer;" onclick="doInvoiceRemove({$invoice.id})"><i class="fa fa-trash-o" aria-hidden="true"></i> {$LANG.invoicedelete}</a>

                        {/if}

                    {* uniweb end *}

                    </td>

                </tr>

            {/foreach}

        </tbody>

    </table>

    <div class="text-center" id="tableLoading">

        <p><i class="fa fa-spinner fa-spin"></i> {$LANG.loading}</p>

    </div>

    </div>

</div>



{* uniweb start *}

{$hp_infoblock}

<script type="text/javascript">

    function doInvoiceRemove(id) {

        if (confirm("Вы действительно хотите удалить этот счет #"+id+"?")) {

            window.location=window.location.href.split("#")[0]+'&operation=remove&id='+id;

        }

    }

</script>



<style type="text/css">

    #tableInvoicesList tbody td {

        vertical-align: middle!important;

    }

    .invoice-description {

    	width: 296px;

    }

</style>

{* uniweb end *}