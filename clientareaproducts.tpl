{* IMPORTANT! FILE WITH CUSTOM CHANGES *}
{include file="$template/includes/tablelist.tpl" tableName="ServicesList" filterColumn="0" noSortColumns="4"}
<script type="text/javascript">
    jQuery(document).ready( function ()
    {
        var table = jQuery('#tableServicesList').removeClass('hidden').DataTable();
        {if $orderby == 'product'}
            table.order([1, '{$sort}'], [3, 'asc']);
        {elseif $orderby == 'amount' || $orderby == 'billingcycle'}
            table.order(2, '{$sort}');
        {elseif $orderby == 'nextduedate'}
            table.order(0, '{$sort}');
        {elseif $orderby == 'domainstatus'}
            table.order(3, '{$sort}');
        {/if}
        table.draw();
        jQuery('#tableLoading').addClass('hidden');
    });
</script>

{include file="$template/pageheader.tpl" title=$LANG.clientareaproducts desc=$LANG.clientareaproductsintro icon=layers}

<div class="panel panel-default panel-datatable">

  <div class="panel-heading clearfix"> {include file="$template/includes/sidebar.tpl" sidebar=$primarySidebar}</div>

    <table id="tableServicesList" class="table table-list hidden">
        <thead>
            <tr>
                <th>{$LANG.clientareastatus}</th>
                <th>{$LANG.orderproduct}</th>
                <th class="hidden-xs">{$LANG.clientareaaddonpricing}</th>
                <th class="hidden-sm hidden-xs">{$LANG.clientareahostingnextduedate}</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            {foreach key=num item=service from=$services}
            {* hostpro start *}
	            {if $service.status eq 'Fraud'}
	 
	            {else}
                <tr>
                    <td><span class="label label-{$service.status|strtolower}">{$service.statustext}</span></td>
                    <td><a href="clientarea.php?action=productdetails&amp;id={$service.id}">{$service.product}</a>{if $service.domain}<br><a href="http://{$service.domain}" target="_blank">{$service.domain}</a>{/if}
                    <ul class="cell-inner-list visible-sm visible-xs">
                    <li><span class="item-title">{$LANG.orderbillingcycle} : </span>{$service.billingcycle}</li>
                    <li><span class="item-title">{$LANG.clientareahostingnextduedate}</span> : {$service.nextduedate}</li>
                    <li class="hidden-sm"><span class="item-title">{$LANG.orderprice} : </span>{$service.amount}</li>
                    </ul>
                    </td>
                    <td data-order="{$service.amountnum}" class="hidden-xs">{$service.amount}<br>{$service.billingcycle}</td>
                    <td class="hidden-sm hidden-xs"><span class="hidden">{$service.normalisedNextDueDate}</span>{if $service.nextduedate == '31/12/1999'} <span class="label label-info"> {$LANG.freetrialperiod}</span> {else}{$service.nextduedate}{/if}</td>                    
                    <td class="text-right"><a class="btn btn-default" href="clientarea.php?action=productdetails&amp;id={$service.id}"><i class="fa fa-cog"></i> {$LANG.productmanagementactions}</a>
                    </td>
                </tr>
                {/if}
            {* hostpro end *} 
            {/foreach}
        </tbody>
    </table>
    <div class="text-center" id="tableLoading">
        <p><i class="fa fa-spinner fa-spin"></i> {$LANG.loading}</p>
    </div>
    <div class="clearfix"></div>
</div>
