{* IMPORTANT! FILE WITH CUSTOM CHANGES *}
    <div class="row">
    	<div class="col-md-12 col-xs-12">
    		<h3 class="page-header"><span aria-hidden="true" class="icon icon-home"></span> {$LANG.dashboard} <i class="fa fa-info-circle animated bounce show-info"></i>
          {if $show_inclientarea != 1 && $showqsl}
          <span class="pull-right flip qsl"><a href="#" data-original-title="Quick Server Logins"><span aria-hidden="true" class="icon icon-settings settings-toggle"></span></a></span>
          {/if}
        </h3>
        <blockquote class="page-information hidden">
         <p>{$LANG.dashboardintro}</p>
       </blockquote>

     </div>
   </div>

   {* hostpro start *}
	{if $unblockip_alerts}
	<div class="row">
	<div class="col-md-12">
	<div class="alert alert-danger textcenter">
	    <p><strong>
	    {$unblockip_alerts}</p>
	    <p><form name='ipaddresscheck' method='POST' action='index.php?m=unblockip'>
	    <input type="text" size="25" name="ip_address" style="text-align: center;" value="{$smarty.server.REMOTE_ADDR}">
	    <input type="hidden" name="action" value="remove_ip_block" /><br/>
	    <input class="btn btn-primary" type="submit" name="unblock" value="{$LANG.request_removal_of_block}" />
	    </form>
	</div>
	{/if}
	{if $unblockip_errors}
	     <div class="alert alert-error textcenter">
	        <p><strong>{$LANG.ip_address_is_blocked}<br>{$LANG.please_open_a_support_ticket}</strong></p>
	     </div>
	  </div>
	</div>
	{/if}
   {* hostpro end *}
   <div class="row px-1 pt-1">
     <div class="col-md-4">
      <a title="{$LANG.navservices}" href="clientarea.php?action=products">
       <div class="info-box bg-info text-white" id="initial-tour">
        <div class="info-icon bg-info-dark">
         <span aria-hidden="true" class="icon icon-layers"></span>
       </div>
       <div class="info-details">
         <h4>{$LANG.navservices}<span class="pull-right flip">{$clientsstats.productsnumtotal}</span></h4>
         <p>{$LANG.clientareaactive}<span class="badge pull-right flip bg-white text-success"> {$clientsstats.productsnumactive}</span> </p>
       </div>
     </div>
   </a>
 </div>
{if $condlinks.domainreg || $condlinks.domaintrans}
 <div class="col-md-4">
  <a title="{$LANG.cartproductdomain}" href="clientarea.php?action=domains">
   <div class="info-box bg-info text-white">
    <div class="info-icon bg-info-dark">
     <span aria-hidden="true" class="icon icon-globe"></span>
   </div>
   <div class="info-details">
     <h4>{$LANG.navdomains}<span class="pull-right flip">{$clientsstats.numdomains}</span></h4>
     <p>{$LANG.clientareaactive}<span class="badge pull-right flip bg-white text-success"> {$clientsstats.numactivedomains} </span> </p>
   </div>
 </div>
</a>
</div>
{/if}
<div class="col-md-4">
<a title="{$clientsstats.numdueinvoices}" href="clientarea.php?action=invoices">
  <div class="info-box bg-info text-white">
   <div class="info-icon bg-info-dark">
    <span aria-hidden="true" class="icon icon-drawer"></span>
  </div>
  <div class="info-details">
    <h4>{$LANG.navinvoices}<span class="pull-right flip">{$clientsstats.numdueinvoices}</span></h4>
    <p><span class="badge">{$clientsstats.dueinvoicesbalance}</span></p>
  </div>
</div>
</a>
</div>
{if $condlinks.addfunds}
<div class="col-md-4">
<a title="{$LANG.addfunds}" href="clientarea.php?action=addfunds">
  <div class="info-box  bg-warn text-white">
   <div class="info-icon bg-warn-dark">
    <span aria-hidden="true" class="icon icon-wallet"></span>
  </div>
  <div class="info-details">
    <h4>{$LANG.statscreditbalance}<span class="pull-right flip">{$clientsstats.creditbalance}</span></h4>
    <p>{$LANG.addfunds1}</p>
  </div>
</div>
</a>
</div>
{/if}
<div class="col-md-4">
 <a title="{$LANG.ordernowbutton}" href="cart.php">
  <div class="info-box  bg-inactive  text-white">
   <div class="info-icon bg-inactive-dark">
    <span aria-hidden="true" class="icon icon-plus"></span>
  </div>
  <div class="info-details">
    <h4>{$LANG.ordernowbutton}</h4>
    <p>{$LANG.statsnumproducts}</p>
  </div>
</div>
</a>
</div>
</div>
{if $announcements}
<div class="panel panel-default panel-news">
  <div class="panel-heading text-uppercase">{$LANG.ourlatestnews}
    <div class="pull-right flip">
    <a class="prev pull-left"><span class="glyphicon glyphicon-chevron-left"></span></a> <a class="next"><span class="glyphicon glyphicon-chevron-right"></span></a></div>
  </div>
  <div class="panel-body">
   <div id="owl-news" class="owl-carousel pb-1">
    <div class="item px-1"><i class="fa fa-clock-o pull-left flip" aria-hidden="true"></i> <a class="date pull-left flip pr-1" href="announcements.php?id={$announcements.0.id}">{$announcements.0.date}</a> {$announcements.0.text|strip_tags|truncate:500:'...'}</div>
    {if $announcements.1.text}
    <div class="item px-1"><i class="fa fa-clock-o pull-left flip" aria-hidden="true"></i><a class="date pull-left flip pr-1" href="announcements.php?id={$announcements.1.id}">{$announcements.1.date}</a> {$announcements.1.text|strip_tags|truncate:500:'...'}</div>
    {/if}
    {if $announcements.2.text}
    <div class="item px-1"><i class="fa fa-clock-o pull-left flip" aria-hidden="true"></i><a class="date pull-left flip pr-1" href="announcements.php?id={$announcements.2.id}">{$announcements.2.date}</a> {$announcements.2.text|strip_tags|truncate:500:'...'}</div>
    {/if}
  </div>
</div>
</div>
{literal}
<script>
  $(document).ready(function() {
  var owl = $("#owl-news");owl.owlCarousel({
      autoHeight : true, loop:true, items:1{/literal}
      {if $LANG.locale == 'ar_AR' || $LANG.locale == 'fa_IR' || $LANG.locale == 'he_IL'} ,rtl:true {/if}{literal}
    });
$('.next').click(function() {
    owl.trigger('next.owl.carousel');
})
$('.prev').click(function() {
    owl.trigger('prev.owl.carousel', [300]);
})
});
</script>
{/literal}
{/if}
{if $ccexpiringsoon}
<div class="alert alert-danger">
 <p><strong>{$LANG.ccexpiringsoon}:</strong> {$LANG.ccexpiringsoondesc|sprintf2:'
  <a href="clientarea.php?action=creditcard" class="btn btn-danger btn-xs pull-right flip">':'</a>'}</p>
</div>
{/if}
{foreach from=$addons_html item=addon_html}
<div class="py-1">{$addon_html}</div>
{/foreach}

{if $show_inclientarea == 1 && $showqsl }
  {include file="$qsl_inclientarea_template"}
{/if}

{*hostpro start*}
{if $clientsdetails.email|strstr:"yandex" || $clientsdetails.email|strstr:"mail.ru" || $clientsdetails.email|strstr:"ya.ru" ||$clientsdetails.email|strstr:"list.ru" ||$clientsdetails.email|strstr:"bk.ru"|| $clientsdetails.email|strstr:"inbox.ru" ||$clientsdetails.email|strstr:"ya.ua"}
<div class="alert alert-info">
  {$LANG.presidentukaz133}
</div>
{/if}
{*hostpro end*}

<div class="row">
  <div class="col-md-12">
    <div class="p-1">
    {if in_array('tickets',$contactpermissions)}
    <ul class="nav nav-material nav-material-horizontal">
     <li class="active"><a href="#home1" data-toggle="tab"><span class="badge badge-circle badge-success">{$clientsstats.numactivetickets}</span> {$LANG.supportticketsopentickets}</a></li>
     <li class="pull-right flip"><a href="submitticket.php"><i aria-hidden="true" class="fa fa-ticket"></i> {$LANG.opennewticket}</a></li>
   </ul>
   <table class="table table-data table-hover px-1">
    <thead>
      <tr>
        <th>{$LANG.supportticketssubject}</th>
        <th class="hidden-sm hidden-xs">{$LANG.supportticketsdepartment}</th>
        <th class="hidden-sm hidden-xs">{$LANG.supportticketsticketurgency}</th>
        <th class="hidden-sm hidden-xs">{$LANG.supportticketsticketlastupdated}</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
      {foreach from=$tickets item=ticket}

      {assign var="label" value="default"}
      {if $ticket.status|strstr:"779500"}{assign var="label" value="success"}
      {elseif $ticket.status|strstr:"000000"}{assign var="label" value="primary"}
      {elseif $ticket.status|strstr:"ff6600"}{assign var="label" value="warning"}
      {elseif $ticket.status|strstr:"224488"}{assign var="label" value="info"}
      {elseif $ticket.status|strstr:"cc0000"}{assign var="label" value="danger"}
      {/if}

      <tr>
        <td>
          <span class="label label-{$label}">{$ticket.status|strip_tags|replace:' ':''}</span> <a href="viewticket.php?tid={$ticket.tid}&amp;c={$ticket.c}">{$ticket.subject}</a>
          <ul class="cell-inner-list">
            <li class="visible-sm visible-xs"><span class="item-title">{$LANG.supportticketsticketlastupdated} : </span>{$ticket.lastreply}</li>
            <li class="visible-sm visible-xs"><span class="item-title">{$LANG.supportticketsdepartment}: </span>{$ticket.department}</li>
            <li class="visible-sm visible-xs"><span class="item-title">{$LANG.supportticketsticketurgency}: </span>{$ticket.urgency}</li>
          </ul>
        </td>
        <td class="hidden-sm hidden-xs">{$ticket.department}</td>
        <td class="hidden-sm hidden-xs">{$ticket.urgency}</td>
        <td class="hidden-sm hidden-xs">{$ticket.lastreply}</td>
        <td><a href="viewticket.php?tid={$ticket.tid}&amp;c={$ticket.c}"><span class="glyphicon glyphicon-chevron-right"></span></a>
        </td>
      </tr>
      {foreachelse}
      <tr>
        <td colspan="6" class="norecords">{$LANG.norecordsfound}</td>
      </tr>{/foreach}
    </tbody>
  </table>
  {/if}
  {if in_array('invoices',$contactpermissions)}
  <ul class="nav nav-material nav-material-horizontal">
    <li class="active"><a href="#home2" data-toggle="tab"><span class="badge badge-circle badge-important">{$clientsstats.numdueinvoices}</span> {$LANG.invoicesdue}</a></li>
    <li class="pull-right flip"><a href="clientarea.php?action=masspay&amp;all=true"><span aria-hidden="true" class="icon icon-arrow-right"></span> {$LANG.masspayall}</a></li>
  </ul>
  <div class="tab-content">
    <div class="tab-pane active" id="home2">

     <form method="post" action="clientarea.php?action=masspay">
      <table {* uniweb start *}id="tableInvoicesList"{* uniweb end *} class="table table-data table-hover">
       <thead>
        <tr>{if $masspay}
         <th class="cell-checkbox">
          <input type="checkbox" onclick="toggleCheckboxes('invids')" />
        </th>{/if}
        <th>{$LANG.invoicestitle}</th>
        {* uniweb start *}
        <th class="invoice-description">{$LANG.invoicedescription}</th>
        {* uniweb end *}
        <th class="text-center hidden-sm hidden-xs" style="white-space: nowrap;">{$LANG.invoicesdatecreated}</th>
        <th class="text-center hidden-sm hidden-xs">{$LANG.invoicesdatedue}</th>
        <th class="text-center hidden-sm hidden-xs">{$LANG.invoicesstatus}</th>
        <th class="text-center hidden-sm hidden-xs">{$LANG.invoicestotal}</th>
        <th class="text-center hidden-sm hidden-xs">{$LANG.actions}</th>
      </tr>
    </thead>
    <tbody>{foreach from=$invoices item=invoice}
      <tr>{if $masspay}
       <td class="cell-checkbox">
        <input type="checkbox" name="invoiceids[]" value="{$invoice.id}" class="invids" />
      </td>{/if}
      <td><a href="viewinvoice.php?id={$invoice.id}" target="_blank" class="item-title">{$invoice.invoicenum}</a>
        <ul class="cell-inner-list visible-sm visible-xs">
         <li><span class="label label-{$invoice.rawstatus} label-danger">{$invoice.statustext}</span></li>
         <li><span class="item-title">{$LANG.invoicestotal} : </span>{$invoice.total}</li>
         <li><span class="item-title">{$LANG.invoicesdatecreated} : </span>{$invoice.datecreated}</li>
         <li><span class="item-title">{$LANG.invoicesdatedue} : </span>{$invoice.datedue}</li>
       </ul>
     </td>
     {* uniweb start *}
     <td>{"<br/>"|implode:$invoicesDescriptions[$invoice.id]|regex_replace:"/\(\d+\/\d+\/\d+ - \d+\/\d+\/\d+\)/":""}</td>
     {* uniweb end *}
     <td class="text-center hidden-sm hidden-xs">{$invoice.datecreated}</td>
     <td class="text-center hidden-sm hidden-xs">{$invoice.datedue}</td>
     <td class="text-center hidden-sm hidden-xs"><span class="label label-{$invoice.rawstatus} label-danger">{$invoice.statustext}</span>
     </td>
     <td class="text-right hidden-sm hidden-xs">{$invoice.total}</td>
     {* uniweb start *}
     <td class="text-right">
        <a href="viewinvoice.php?id={$invoice.id}" title="{'<br/>'|implode:$invoicesDescriptions[$invoice.id]}" >
            <i class="fa fa-file-text-o" aria-hidden="true"></i> {$LANG.invoiceopen}
        </a>
        {if in_array($invoice.id, $isInvoisesRemove)}
        <span style="color: #DDDDDD;margin: 0 5px;">|</span>   <a class="text-danger" style="cursor: pointer;" onclick="doInvoiceRemove({$invoice.id})"><i class="fa fa-trash-o" aria-hidden="true"></i> {$LANG.invoicedelete}</a>
        {/if}
     </td>
     {* uniweb end *}
     </td>
   </tr>{foreachelse}
   <tr>
     <td colspan="{if $masspay}7{else}7{/if}" class="norecords">{$LANG.norecordsfound}</td>
   </tr>{/foreach}</tbody>{if $masspay}
   <tfoot>
     <tr>
      <td class="cell-checkbox"><input type="checkbox" onclick="toggleCheckboxes('invids')" class="invids" /></td>
      <td colspan="5" class=""><input type="submit" name="masspayselected" value="{$LANG.masspayselected}" class="btn btn-default btn-xs" /></td><td class="hidden-sm"></td>
    </tr>
  </tfoot>{/if}
</table>
</form>
</div>
</div>
{/if}
</div>
</div>
</div>
{if $files}
<h3>{$LANG.clientareafiles}</h3>
<div class="row">
  <div class="form-group">{foreach from=$files item=file}
   <div class="col-lg-6"><div class="well well-sm">
    <a href="dl.php?type=f&amp;id={$file.id}"><h4><span class="glyphicon glyphicon-floppy-disk"></span> {$file.title}</h4></a>
    <p>{$LANG.clientareafilesdate}: {$file.date}</p></div></div>{/foreach}</div>
  </div>
  {/if}
  <div class="right-sidebar right-sidebar-hidden">
   <div class="right-sidebar-holder">
     <h4 class="page-header">{$LANG.quickserverlogins}<a href="javascript:;"  class="theme-panel-close text-primary pull-right flip"><span aria-hidden="true" class="icon icon-close"></span></a></h4>
      {if $show_inclientarea != 1 && $showqsl}
        {include file="$qsl_modalarea_template"}
      {/if}
    </div>
  </div>
{* uniweb start *}
<script type="text/javascript">
    function doInvoiceRemove(id) {
        if (confirm("Вы действительно хотите удалить этот счет #"+id+"?")) {
        	window.location='/clientarea.php?action=invoices&operation=remove&id='+id;
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
