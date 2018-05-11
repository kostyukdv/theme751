{* IMPORTANT! FILE WITH CUSTOM CHANGES *}
{include file="$template/pageheader.tpl" title=$LANG.clientareanavdomains desc=$LANG.clientareadomainsintro icon=globe}
{* uniweb start *}
<p><h5>Ваш текущий статус - <span class="badge badge-success"><i class="fa fa-user"></i> {$hostprodata.client.group_name}</span></h5></p>
<div class="alert alert-warning">
         <a href="http://support.hostpro.ua/index.php?/Knowledgebase/Article/View/308/33/izmenenija-v-porjadke-registrcii-mezhdunrodnykh-domenov" target="_blank" style="color: #FF8800;"><i class="fa fa-exclamation-circle" aria-hidden="true"></i> <strong>Внимание!</strong> Изменился порядок регистрации международных доменов</a>
</div>
{* uniweb end *}
{if $warnings}
    {include file="$template/includes/alert.tpl" type="warning" msg=$warnings textcenter=true}
{/if}
<div class="tab-content">
    <div class="tab-pane fade in active" id="tabOverview">
        {include file="$template/includes/tablelist.tpl" tableName="DomainsList" noSortColumns="0, 7" startOrderCol="1" filterColumn="6"}

        <script type="text/javascript">
            jQuery(document).ready( function ()
            {
                var table = jQuery('#tableDomainsList').removeClass('hidden').DataTable();
                {if $orderby == 'domain'}
                    table.order(1, '{$sort}');
                {elseif $orderby == 'regdate' || $orderby == 'registrationdate'}
                    table.order(2, '{$sort}');
                {elseif $orderby == 'nextduedate'}
                    table.order(3, '{$sort}');
                {elseif $orderby == 'autorenew'}
                    table.order(4, '{$sort}');
                {elseif $orderby == 'status'}
                    table.order(5, '{$sort}');
                {/if}
                table.draw();
                jQuery('#tableLoading').addClass('hidden');
            });
        </script>
        <form id="domainForm" method="post" action="clientarea.php?action=bulkdomain">
            <input id="bulkaction" name="update" type="hidden" />
            <div class="panel panel-default panel-datatable">
              <div class="panel-heading clearfix"> {include file="$template/includes/sidebar.tpl" sidebar=$primarySidebar}</div>
                <table id="tableDomainsList" class="table table-list hidden">
                    <thead>
                        <tr>
                            <th></th>
                            <th>{$LANG.orderdomain}</th>
                            {* uniweb start *}<th style="min-width:60px;">Зона</th> {* uniweb end *}
                            <th class="hidden-sm hidden-xs">{$LANG.regdate}</th>
                            <th class="hidden-xs">{$LANG.nextdue}</th>
                            <th class="hidden-sm hidden-xs">{$LANG.domainsautorenew}</th>
                            <th class="hidden-xs">{$LANG.domainstatus}</th>
                            <th>&nbsp;</th>
                        </tr>
                    </thead>
                    <tbody>
                    {foreach key=num item=domain from=$domains}
                        {* hostpro start *}
                    	{if $domain.status eq 'Fraud'}
                    	{else}
                        <tr>
                            <td><input type="checkbox" name="domids[]" class="domids stopEventBubble" value="{$domain.id}" /></td>
                            <td><a href="http://{$domain.domain}" target="_blank">{$domain.domain}</a>

                           <ul class="cell-inner-list visible-xs">
                           <li><span class="label status status-{$domain.statusClass}">{$domain.statustext}</span></li>
                           </ul>
                            <ul class="cell-inner-list visible-sm visible-xs small">
                            <li><span class="item-title">{$LANG.clientareahostingnextduedate}: </span>{$domain.nextduedate}</li>
                            <li><span class="item-title">{$LANG.clientareahostingregdate}: </span>{$domain.registrationdate}</li>
                            <li><span class="item-title">{$LANG.domainsautorenew}: </span>{if $domain.autorenew}{$LANG.domainsautorenewenabled} <i class="fa fa-fw fa-check text-success"></i>{else}{$LANG.domainsautorenewdisabled} <i class="fa fa-fw fa-times text-danger"></i>{/if}</li>
                            </ul>

                            </td>
                            {* uniweb start *}<td>{$domain_zones[$domain.domain]}</td>{* uniweb end *}
                            <td class="hidden-sm hidden-xs"><span class="hidden">{$domain.normalisedRegistrationDate}</span>{$domain.registrationdate}</td>
                            <td class="hidden-xs"><span class="hidden">{$domain.normalisedNextDueDate}</span>{$domain.nextduedate}</td>
                            <td class="hidden-sm hidden-xs">
                                {if $domain.autorenew}
                                    <i class="fa fa-fw fa-check text-success"></i> {$LANG.domainsautorenewenabled}
                                {else}
                                    <i class="fa fa-fw fa-times text-danger"></i> {$LANG.domainsautorenewdisabled}
                                {/if}
                            </td>
                            <td class="hidden-xs">
                                <span class="label status status-{$domain.statusClass}">{$domain.statustext}</span>
                                <span class="hidden">
                                ~{$domain.statustext}~
                                {if $domain.next30}<span>{$LANG.domainsExpiringInTheNext30Days}</span><br />{/if}
                                {if $domain.next90}<span>{$LANG.domainsExpiringInTheNext90Days}</span><br />{/if}
                                {if $domain.next180}<span>{$LANG.domainsExpiringInTheNext180Days}</span><br />{/if}
                                {if $domain.after180}<span>{$LANG.domainsExpiringInMoreThan180Days}</span>{/if}
                                </span>
                            </td>
                            <td class="text-right">
                                <div class="btn-group">
                                    <a href="clientarea.php?action=domaindetails&id={$domain.id}" class="btn btn-default btn-default-left"><i class="glyphicon glyphicon-cog"></i>{if $mini} {$LANG.managedomain}{else} {/if}</a>
                                    <button type="button" class="btn btn-default btn-default-right dropdown-toggle" data-toggle="dropdown">
                                        <span class="caret"></span>
                                        <span class="sr-only">Toggle Dropdown</span>
                                    </button>
                                    <ul class="dropdown-menu text-left" style="left: -115px !important;" role="menu">
                                        {if $domain.status eq 'Active'}
                                            <li><a href="clientarea.php?action=domaindetails&id={$domain.id}#tabNameservers"><i class="glyphicon glyphicon-globe"></i> {$LANG.domainmanagens}</a></li>
                                            <li><a href="clientarea.php?action=domaincontacts&domainid={$domain.id}"><i class="glyphicon glyphicon-user"></i> {$LANG.domaincontactinfoedit}</a></li>
                                            <li><a href="clientarea.php?action=domaindetails&id={$domain.id}#tabAutorenew"><i class="glyphicon glyphicon-globe"></i> {$LANG.domainautorenewstatus}</a></li>
                                            <li class="divider"></li>
                                        {/if}
                                        <li><a href="clientarea.php?action=domaindetails&id={$domain.id}"><i class="glyphicon glyphicon-pencil"></i> {$LANG.managedomain}</a></li>
                                    </ul>
                                </div>
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
            </div>
        </form>

        <div class="btn-group pb-lg-30 px-sm-15">
            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                <span class="glyphicon glyphicon-folder-open"></span> &nbsp; {$LANG.withselected} <span class="caret"></span>
            </button>
            <ul class="dropdown-menu" role="menu">
                <li><a href="#" id="nameservers" class="setBulkAction"><i class="glyphicon glyphicon-globe"></i> {$LANG.domainmanagens}</a></li>
                <li><a href="#" id="autorenew" class="setBulkAction"><i class="glyphicon glyphicon-refresh"></i> {$LANG.domainautorenewstatus}</a></li>
                {* hostpro start *}
                <li style="display: none;"><a href="#" id="reglock" class="setBulkAction"><i class="glyphicon glyphicon-lock"></i> {$LANG.domainreglockstatus}</a></li>
                {* hostpro end *}
                <li><a href="#" id="contactinfo" class="setBulkAction"><i class="glyphicon glyphicon-user"></i> {$LANG.domaincontactinfoedit}</a></li>
                {* uniweb start *}
                <li><a href="#" id="renew" class="setBulkAction"><i class="glyphicon glyphicon-repeat"></i> {$LANG.domainmassrenew}</a></li>
                {* uniweb end *}
            </ul>
        </div>
    </div>
    <div class="tab-pane fade in" id="tabRenew">
        {include file="$template/includes/tablelist.tpl" tableName="RenewalsList" noSortColumns="3, 4, 5" startOrderCol="0" filterColumn="1" dontControlActiveClass=true}
        <script type="text/javascript">
            var observer = new MutationObserver(function(mutations) {
                jQuery('#Secondary_Sidebar-My_Domains_Actions-Renew_Domain').toggleClass('active')
            });
            var target = document.querySelector('#tabRenew');
            observer.observe(target, {
                attributes: true
            });

        </script>
        <div class="table-container clearfix">
            <table id="tableRenewalsList" class="table table-list">
                <thead>
                    <tr>
                        <th>{$LANG.orderdomain}</th>
                        <th>{$LANG.domainstatus}</th>
                        <th>{$LANG.clientareadomainexpirydate}</th>
                        <th>{$LANG.domaindaysuntilexpiry}</th>
                        <th>&nbsp;</th>
                        <th>
                            <div id="btnCheckout" style="display:none;">
                                <a href="cart.php?a=view" class="btn btn-default">{$LANG.domainsgotocheckout} &raquo;</a>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    {foreach $renewals as $id => $renewal}
                        <tr id="domainRow{$renewal.id}" {if $selectedIDs && in_array($renewal.id, $selectedIDs)}class="highlight"{/if}>
                            <td id="domain{$renewal.id}">{$renewal.domain}</td>
                            <td id="status{$renewal.id}">
                                <span class="label status status-{$renewal.statusClass}">{$renewal.status}</span>
                                <span class="hidden">
                                    {if $renewal.next30}{$LANG.domainsExpiringInTheNext30Days}<br />{/if}
                                    {if $renewal.next90}{$LANG.domainsExpiringInTheNext90Days}<br />{/if}
                                    {if $renewal.next180}{$LANG.domainsExpiringInTheNext180Days}<br />{/if}
                                    {if $renewal.after180}{$LANG.domainsExpiringInMoreThan180Days}{/if}
                                </span>
                            </td>
                            <td id="expiry{$renewal.id}"><span class="hidden">{$renewal.normalisedExpiryDate}</span>{$renewal.expiryDate}</td>
                            <td id="days{$renewal.id}" class="text-center">
                                {if $renewal.daysUntilExpiry > 30}
                                    <span class="text-success">{$renewal.daysUntilExpiry} {$LANG.domainrenewalsdays}</span>
                                {elseif $renewal.daysUntilExpiry > 0}
                                    <span class="text-warning">{$renewal.daysUntilExpiry} {$LANG.domainrenewalsdays}</span>
                                {else}
                                    <span class="text-danger">{$renewal.daysUntilExpiry*-1} {$LANG.domainrenewalsdaysago}</span>
                                {/if}
                                {if $renewal.inGracePeriod}
                                    <br />
                                    <span class="text-danger">{$LANG.domainrenewalsingraceperiod}</span>
                                {/if}
                            </td>
                            <td id="period{$renewal.id}" class="text-center">
                                {if $renewal.beforeRenewLimit}
                                    <span class="text-danger">
                                        {$LANG.domainrenewalsbeforerenewlimit|sprintf2:$renewal.beforeRenewLimitDays}
                                    </span>
                                {elseif $renewal.pastGracePeriod}
                                    <span class="textred">{$LANG.domainrenewalspastgraceperiod}</span>
                                {else}
                                    <select id="renewalPeriod{$renewal.id}" name="renewalPeriod[{$renewal.id}]">
                                        {foreach $renewal.renewalOptions as $renewalOption}
                                            <option value="{$renewalOption.period}">
                                                {$renewalOption.period} {$LANG.orderyears} @ {$renewalOption.price}
                                            </option>
                                        {/foreach}
                                    </select>
                                {/if}
                            </td>
                            <td class="text-center">
                                {if !$renewal.beforeRenewLimit && !$renewal.pastGracePeriod}
                                    <button type="button" class="btn btn-primary btn-sm" id="renewButton{$renewal.id}" onclick="addRenewalToCart({$renewal.id}, this)">
                                        <span class="glyphicon glyphicon-shopping-cart"></span> {$LANG.addtocart}
                                    </button>
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>

        <div class="row">
            <div class="col-xs-12" id="backLink">
                <a href="#tabOverview" class="btn btn-default btn-sm" data-toggle="tab" id="back">
                    <i class="glyphicon glyphicon-backward"></i> {$LANG.clientareabacklink|replace:'&laquo; ':''}
                </a>
            </div>
        </div>
    </div>
</div>
{* uniweb start *}
{literal}
<script>
$(document).ready(function() {
	$("#renew").click(function(event) {
		event.preventDefault();
		
		$("#bulkaction").val($(this).attr('id'));
		$('#domainForm').prop('action','cart.php?gid=renewals').submit();
	});
});
</script>
{/literal}
{* uniweb end *}
