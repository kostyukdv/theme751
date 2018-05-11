{include file="$template/pageheader.tpl" title=$product}
<br>
{if $modulecustombuttonresult}
    {if $modulecustombuttonresult == "success"}
        {include file="$template/includes/alert.tpl" type="success" msg=$LANG.moduleactionsuccess textcenter=true idname="alertModuleCustomButtonSuccess"}
    {else}
        {include file="$template/includes/alert.tpl" type="error" msg=$LANG.moduleactionfailed|cat:' ':$modulecustombuttonresult textcenter=true idname="alertModuleCustomButtonFailed"}
    {/if}
{/if}

{if $pendingcancellation}
    {include file="$template/includes/alert.tpl" type="error" msg=$LANG.cancellationrequestedexplanation textcenter=true idname="alertPendingCancellation"}
{/if}
<ul class="nav nav-tabs" id="tabs">
    <li class="active"><a href="#tabOverview" data-toggle="tab">{$LANG.information}</a></li>
    {if $modulechangepassword}<li><a href="#tabChangepw" data-toggle="tab">{$LANG.serverchangepassword}</a></li>{/if}
    {if $downloads}<li><a href="#tabDownloads" data-toggle="tab">{$LANG.downloadstitle}</a></li>{/if}
    {if $addonsavailable}<li><a href="#tabAddons" data-toggle="tab">{$LANG.clientareahostingaddons}</a></li>{/if}
    {if $enablebackup}<li><a href="#tabModuleBackups" data-toggle="tab">{$LANG.clientAreaBackup}</a></li>{/if}
    {if $packagesupgrade || $configoptionsupgrade || $showcancelbutton || $modulecustombuttons}<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">{$LANG.productmanagementactions}</a>
    <ul class="dropdown-menu">
        {foreach from=$modulecustombuttons key=label item=command}
        <li><a href="clientarea.php?action=productdetails&amp;id={$id}&amp;modop=custom&amp;a={$command}">{$label}</a></li>
        {/foreach}
        {if $packagesupgrade}<li><a href="upgrade.php?type=package&amp;id={$id}">{$LANG.upgradedowngradepackage}</a></li>{/if}
        {if $configoptionsupgrade}<li><a href="upgrade.php?type=configoptions&amp;id={$id}">{$LANG.upgradedowngradeconfigoptions}</a></li>{/if}
        {if $showcancelbutton}<li><a href="clientarea.php?action=cancel&amp;id={$id}">{$LANG.clientareacancelrequestbutton}</a></li>{/if}
    </ul>
</li>{/if}
    {* uniweb start *}{if $product == "GuruHosting" || $product == "GuruHosting-Trial" || $product == "Guru-Dev"}
    <li><a href="#tabMetrika" data-toggle="tab">{$LANG.resourceUsage}</a></li>
    {/if}{* uniweb end *}
    {* hostpro start *}{if $groupname == "SSL-сертификаты" || $groupname == "Акция" }
        <li><a href="#tabSSL" data-toggle="tab">CSR-генератор</a></li>
    {/if}{* hostpro end *}
</ul>
<div class="tab-content" >
    <div class="tab-pane active" id="tabOverview">
        {if $tplOverviewTabOutput}
        {$tplOverviewTabOutput}
        {if $serverdata.type eq 'cpanel'}
        {if $moduleclientarea && $pid != "1124"}<div class="moduleoutput text-right">{$moduleclientarea|replace:'modulebutton':'btn'}</div>{/if}
        {if $pid == "1124"}<div class="moduleoutput text-center">{$siteprobuilder|replace:'btn':'btn btn-success'}</div>{/if}
        {/if}
         {*hostpro start*}
         <div style="margin-top:10px;"></div>
         {$intCode}
         {*hostpro end*}
        {else}
        <div class="product-details clearfix">
            <div class="row">
                <div class="col-md-6 text-center">
                    <div class="product-icon">

                        <span class="fa-stack fa-2x">
                            <i class="fa fa-circle fa-stack-2x"></i>
                            <i class="fa fa-{if $type eq "hostingaccount" || $type == "reselleraccount"}hdd-o{elseif $type eq "server"}database{else}archive{/if} fa-stack-1x fa-inverse"></i>
                        </span>

                        <h4 >{$product} - {$domain}<span class="label label-default label-{$status|strtolower}">{$status}</span></h4>
                        <h4><small>{$groupname}</small></h4>
                    </div>
                    {if $showcancelbutton || $packagesupgrade}
                    <div class="row">
                        {if $packagesupgrade}
                                    <div class="col-xs-{if $showcancelbutton}6{else}12{/if}">
                                        <a href="upgrade.php?type=package&amp;id={$id}" class="btn btn-block btn-success">{$LANG.upgrade}</a>
                                    </div>
                                {/if}
                                {if $showcancelbutton}
                                    <div class="col-xs-{if $packagesupgrade}6{else}6{/if}">
                                        <a href="clientarea.php?action=cancel&amp;id={$id}" class="btn btn-block btn-danger {if $pendingcancellation}disabled{/if}">{if $pendingcancellation}{$LANG.cancellationrequested}{else}{$LANG.clientareacancelrequestbutton}{/if}</a>
                                    </div>
                                {/if}
                            </div>
                        {/if}
                    </div>
                    <div class="col-md-6 product-extra" {if $groupname eq "Wordpress Хостинг" || $groupname eq "Wordpress Hosting"} style="color: #fff;"{/if}>
                        <dl class="dl-horizontal">
                          <dt>{$LANG.clientareahostingregdate}</dt>
                          <dd>{$regdate}</dd>
                          {if $firstpaymentamount neq $recurringamount}
                          <dt>{$LANG.firstpaymentamount}</dt>
                          <dd>{$firstpaymentamount}</dd>
                          {/if}

                          {if $billingcycle != $LANG.orderpaymenttermonetime && $billingcycle != $LANG.orderfree }
                          <dt>{$LANG.recurringamount}</dt>
                          <dd>{$recurringamount}</dd>
                          {/if}
                          <dt>{$LANG.orderbillingcycle}</dt>
                          <dd>{$billingcycle}</dd>
                          <dt>{$LANG.clientareahostingnextduedate}</dt>
                          <dd>{$nextduedate}</dd>
                          <dt>{$LANG.orderpaymentmethod}</dt>
                          <dd>{$paymentmethod}</dd>
			  {if $suspendreason}
                          <dt>{$LANG.suspendreason}</dt>
                          <dd>{$suspendreason}</dd>
                         {/if}
                      </dl>
                  </div>
                      {*hostpro start*}
                      <div>
                       {include file="$template/hosting_renew_form_six.tpl"}
                      </div>
                      <div class="clear"></div>
                      {*hostpro end*}
              </div>
          </div>
          {foreach $hookOutput as $output}
          <div>
            {$output}
        </div>
        {/foreach}

        {if  $domain || $moduleclientarea || $configurableoptions || $customfields || $lastupdate}
        {if $groupname eq "Wordpress Хостинг" || $groupname eq "Wordpress Hosting"} {else}
        <div class="row clearfix" >
            <div class="col-xs-12">
                <ul class="nav nav-tabs nav-tabs-overflow">
                    {if $domain}
                    <li class="active">
                        <a href="#domain" data-toggle="tab"><i class="fa fa-globe fa-fw"></i> {if $type eq "server"}{$LANG.sslserverinfo}{elseif ($type eq "hostingaccount" || $type eq "reselleraccount") && $serverdata}{$LANG.hostingInfo}{else}{$LANG.clientareahostingdomain}{/if}</a>
                    </li>
                    {elseif $moduleclientarea}
                    <li class="active">
                        <a href="#manage" data-toggle="tab"><i class="fa fa-globe fa-fw"></i> {$LANG.manage}</a>
                    </li>
                    {/if}
                    {if $configurableoptions}
                    <li{if !$domain && !$moduleclientarea} class="active"{/if}>
                    <a href="#configoptions" data-toggle="tab"><i class="fa fa-cubes fa-fw"></i> {$LANG.orderconfigpackage}</a>
                </li>
                {/if}
                {if $customfields}
                <li{if !$domain && !$moduleclientarea && !$configurableoptions} class="active"{/if}>
                <a href="#additionalinfo" data-toggle="tab"><i class="fa fa-info fa-fw"></i> {$LANG.additionalInfo}</a>
            </li>
            {/if}
            {if $lastupdate}
            <li{if !$domain && !$moduleclientarea && !$configurableoptions && !$customfields} class="active"{/if}>
            <a href="#resourceusage" data-toggle="tab"><i class="fa fa-inbox fa-fw"></i> {$LANG.resourceUsage}</a>
        </li>
        {/if}
    </ul>
</div>
</div>{/if}

<div class="tab-content product-details-tab-container">
    {if $domain}
    <div class="tab-pane fade in active text-center" id="domain">
        {if $type eq "server"}
        <div class="row">
            <div class="col-sm-5 text-right">
                <strong>{$LANG.serverhostname}</strong>
            </div>
            <div class="col-sm-7 text-left">
                {$domain}
            </div>
        </div>
        {if $dedicatedip}
        <div class="row">
            <div class="col-sm-5 text-right">
                <strong>{$LANG.primaryIP}</strong>
            </div>
            <div class="col-sm-7 text-left">
                {$dedicatedip}
            </div>
        </div>
        {/if}
        {if $assignedips}
        <div class="row">
            <div class="col-sm-5 text-right">
                <strong>{$LANG.assignedIPs}</strong>
            </div>
            <div class="col-sm-7 text-left">
                {$assignedips|nl2br}
            </div>
        </div>
        {/if}
        {if $ns1 || $ns2}
        <div class="row">
            <div class="col-sm-5 text-right">
                <strong>{$LANG.domainnameservers}</strong>
            </div>
            <div class="col-sm-7 text-left">
                {$ns1}<br />{$ns2}
            </div>
        </div>
        {/if}

        {elseif ($type eq "hostingaccount" || $type eq "reselleraccount") && $serverdata}
        {if $groupname eq "Wordpress Хостинг" || $groupname eq "Wordpress Hosting"}

        {else}

        {if $domain}
        <div class="row">
            <div class="col-sm-5 text-right">
                <strong>{$LANG.orderdomain}</strong>
            </div>
            <div class="col-sm-7 text-left">
                {$domain}&nbsp;<a href="http://{$domain}" target="_blank" class="btn btn-default btn-xs" >{$LANG.visitwebsite}</a>
            </div>
        </div>
        {/if}
        {if $username }
        <div class="row">
            <div class="col-sm-5 text-right">
                <strong>{$LANG.serverusername}</strong>
            </div>
            <div class="col-sm-7 text-left">
                {$username}
            </div>
        </div>
        {/if}
        {/if}
        {if $groupname eq "Wordpress Хостинг" || $groupname eq "Wordpress Hosting"}

        {else}
        <div class="row">
            <div class="col-sm-5 text-right">
                <strong>{$LANG.servername}</strong>
            </div>
            <div class="col-sm-7 text-left">
                {$serverdata.hostname}
            </div>
        </div>
        <div class="row">
            <div class="col-sm-5 text-right">
                <strong>{$LANG.domainregisternsip}</strong>
            </div>
            <div class="col-sm-7 text-left">
                {$serverdata.ipaddress}
            </div>
        </div>
        {/if}
        {if $groupname eq "Wordpress Хостинг" || $groupname eq "Wordpress Hosting"}

        {else}
        {if $serverdata.nameserver1 || $serverdata.nameserver2 || $serverdata.nameserver3 || $serverdata.nameserver4 || $serverdata.nameserver5}
        <div class="row">
            <div class="col-sm-5 text-right">
                <strong>{$LANG.domainnameservers}</strong>
            </div>
            <div class="col-sm-7 text-left">
                {if $serverdata.nameserver1}{$serverdata.nameserver1} ({$serverdata.nameserver1ip})<br />{/if}
                {if $serverdata.nameserver2}{$serverdata.nameserver2} ({$serverdata.nameserver2ip})<br />{/if}
                {if $serverdata.nameserver3}{$serverdata.nameserver3} ({$serverdata.nameserver3ip})<br />{/if}
                {if $serverdata.nameserver4}{$serverdata.nameserver4} ({$serverdata.nameserver4ip})<br />{/if}
                {if $serverdata.nameserver5}{$serverdata.nameserver5} ({$serverdata.nameserver5ip})<br />{/if}
            </div>
        </div>
        {/if}
        {/if}
        {else}
        <p>
            {$domain}
        </p>
        <p>
            <a href="http://{$domain}" class="btn btn-default" target="_blank">{$LANG.visitwebsite}</a>
            {if $domainId}
            <a href="clientarea.php?action=domaindetails&id={$domainId}" class="btn btn-default" target="_blank">{$LANG.managedomain}</a>
            {/if}
            <input type="button" onclick="popupWindow('whois.php?domain={$domain}','whois',650,420);return false;" value="{$LANG.whoisinfo}" class="btn btn-default" />
        </p>
        {/if}
        {if $moduleclientarea}
        <div class="module-client-area text-center">
            {* hostpro start *}
            {* hostpro end *}
            {$moduleclientarea|replace:'modulebutton':'btn btn-primary'}
        </div>
        {/if}
    </div>
    {elseif $moduleclientarea}
    <div class="tab-pane fade{if !$domain} in active{/if} text-center" id="manage">
        {if $moduleclientarea}
        <div class="text-center module-client-area">
            {$moduleclientarea}
        </div>
        {/if}
    </div>
    {/if}
    {if $configurableoptions}
    <div class="tab-pane fade{if !$domain && !$moduleclientarea} in active{/if} text-center" id="configoptions">
        {foreach from=$configurableoptions item=configoption}
        <div class="row">
            <div class="col-sm-5">
                <strong>{$configoption.optionname}</strong>
            </div>
            <div class="col-sm-7 text-left">
                {if $configoption.optiontype eq 3}{if $configoption.selectedqty}{$LANG.yes}{else}{$LANG.no}{/if}{elseif $configoption.optiontype eq 4}{$configoption.selectedqty} x {$configoption.selectedoption}{else}{$configoption.selectedoption}{/if}
            </div>
        </div>
        {/foreach}
    </div>
    {/if}
    {if $customfields}
    <div class="tab-pane fade{if !$domain && !$moduleclientarea && !$configurableoptions} in active{/if} text-center" id="additionalinfo">
        {foreach from=$customfields item=field}
        <div class="row">
            <div class="col-sm-5">
                <strong>{$field.name}</strong>
            </div>
            <div class="col-sm-7 text-left">
                {$field.value}
            </div>
        </div>
        {/foreach}
    </div>
    {/if}
    {if $lastupdate}
    <div class="tab-pane fade text-center" id="resourceusage" >

        <div class="col-sm-10 col-sm-offset-1">
            <div class="col-sm-6">
                <h4>{$LANG.diskSpace}</h4>
                <input type="text" value="{$diskpercent|substr:0:-1}" class="dial-usage" data-width="100" data-height="100" data-min="0" data-readOnly="true" />
                <p>{$diskusage}MB / {$disklimit}MB</p>
            </div>
            <div class="col-sm-6">
                <h4>{$LANG.bandwidth}</h4>
                <input type="text" value="{$bwpercent|substr:0:-1}" class="dial-usage" data-width="100" data-height="100" data-min="0" data-readOnly="true" />
                <p>{$bwusage}MB / {$bwlimit}MB</p>
            </div>
        </div>
        <div class="clearfix">
        </div>
        <p class="text-muted">{$LANG.clientarealastupdated}: {$lastupdate}</p>
        <script src="{$BASE_PATH_JS}/jquery.knob.js"></script>
        <script type="text/javascript">
            jQuery(function() {ldelim}
                jQuery(".dial-usage").knob({ldelim}'format':function (v) {ldelim} alert(v); {rdelim}{rdelim});
                {rdelim});
        </script>
    </div>
    {/if}
</div>
{/if}
<script src="{$BASE_PATH_JS}/bootstrap-tabdrop.js"></script>
<script type="text/javascript">
    jQuery('.nav-tabs-overflow').tabdrop();
</script>
{/if}
</div>

<div class="tab-pane" id="tabDownloads">
    <h3>{$LANG.downloadstitle}</h3>
    {include file="$template/includes/alert.tpl" type="info" msg="{lang key="clientAreaProductDownloadsAvailable"}" textcenter=true}
    <div class="row">
        {foreach from=$downloads item=download}
        <div class="col-xs-10 col-xs-offset-1">
            <h4>{$download.title}</h4>
            <p>
                {$download.description}
            </p>
            <p>
                <a href="{$download.link}" class="btn btn-default"><i class="fa fa-download"></i> {$LANG.downloadname}</a>
            </p>
        </div>
        {/foreach}
    </div>
</div>
<div class="tab-pane" id="tabAddons">
    <h3>{$LANG.clientareahostingaddons}</h3>
    {if $addonsavailable}
    {include file="$template/includes/alert.tpl" type="info" msg="{lang key="clientAreaProductAddonsAvailable"}" textcenter=true}
    {/if}
    <div class="row">
        {foreach from=$addons item=addon}
        <div class="col-xs-10 col-xs-offset-1">
            <h4>{$addon.name}</h4>
            <p>
                {$addon.pricing}
            </p>
            <p>
                {$LANG.registered}: {$addon.regdate}
            </p>
            <p>
                {$LANG.clientareahostingnextduedate}: {$addon.nextduedate}
            </p>
            <p>
                <span class="label status-{$addon.rawstatus|strtolower}">{$addon.status}</span>
            </p>
        </div>
        {/foreach}
    </div>
</div>
<div class="tab-pane" id="tabChangepw">
    <h3>{$LANG.serverchangepassword}</h3>
    {if $modulechangepwresult}
    {if $modulechangepwresult == "success"}
    {include file="$template/includes/alert.tpl" type="success" msg=$modulechangepasswordmessage textcenter=true}
    {elseif $modulechangepwresult == "error"}
    {include file="$template/includes/alert.tpl" type="error" msg=$modulechangepasswordmessage|strip_tags textcenter=true}
    {/if}
    {/if}
    <form class="form-horizontal using-password-strength" method="post" action="{$smarty.server.PHP_SELF}?action=productdetails#tabChangepw" role="form">
        <input type="hidden" name="id" value="{$id}" />
        <input type="hidden" name="modulechangepassword" value="true" />
        <div id="newPassword1" class="form-group has-feedback">
            <label for="inputNewPassword1" class="col-sm-5 control-label">{$LANG.newpassword}</label>
            <div class="col-sm-6">
                <input type="password" class="form-control" id="inputNewPassword1" name="newpw" autocomplete="off" />
                <span class="form-control-feedback glyphicon"></span>
                {include file="$template/includes/pwstrength-notips.tpl"}
            </div>
        </div>
        <div id="newPassword2" class="form-group has-feedback">
            <label for="inputNewPassword2" class="col-sm-5 control-label">{$LANG.confirmnewpassword}</label>
            <div class="col-sm-6">
                <input type="password" class="form-control" id="inputNewPassword2" name="confirmpw" autocomplete="off" />
                <span class="form-control-feedback glyphicon"></span>
                <div id="inputNewPassword2Msg">
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-6 col-sm-6">
                <input class="btn btn-success" type="submit" value="{$LANG.clientareasavechanges}" />
                <input class="btn btn-default" type="reset" value="{$LANG.cancel}" />
            </div>
        </div>
    </form>
</div>
{* uniweb start *}
<div class="tab-pane" id="tabMetrika">
	<table class="table table-striped" id="hp-module-statistic-history-usage" style="font-size: 12px; display:none;">
        <thead>
            <tr>
            	<th>{$LANG.diskSpace}</th>
                <th>{$LANG.CpuUsage}</th>
                <th>{$LANG.MemUsage}</th>
                <th>{$LANG.hp_statisticmodule_amount}</th>
                <th>{$LANG.hp_statisticmodule_date}</th>
            </tr>
        </thead>
        <tbody id="hp-module-statistic-table">
                <tr id="hp-module-statistic-history-usage-nothing-display" style="display:none;">
                    <td colspan="5" style="text-align: center"><b>Nothing to Display</b></td>
                </tr>
        </tbody>
    </table>
    <div class="dataTables_paginate paging_simple_numbers" style="float: right;">
    	<ul class="pagination">
    		<li class="paginate_button previous disabled" tabindex="0">
    			<a href="#">Назад</a>
			</li>
			<li class="paginate_button next" tabindex="0">
				<a href="#">Вперед</a>
			</li>
		</ul>
	</div>

    <script type="text/javascript">
     {literal}
     	var page = 1;

     	function getPageStatistic(page) {
     		jQuery.getJSON('https://billing.hostpro.ua/elastic/history_usage.php?id={/literal}{$id}{literal}&page='+page, function(data) {
     			if (data != undefined) {
     				$('#hp-module-statistic-table').text('');
     				data.forEach(function(item, i) {
     					if (i != 20) {
	     					var tableRow = '<tr>';

	     					tableRow += '<td>'+item['storage']+'GB ($'+item['amount_storage']+')</td>';
	     					tableRow += '<td>'+item['apcpu']+'% ($'+item['amount_cpu']+')</td>';
	     					tableRow += '<td>'+item['apmem']+'MB ($'+item['amount_mem']+')</td>';
	     					tableRow += '<td>$'+item['amount']+'</td>';
	     					tableRow += '<td>'+item['date']+'</td>';

	     					tableRow += '</tr>';
	     					$('#hp-module-statistic-table').append(tableRow);
     					}
     				});
     			}
     			else {
     				$('#hp-module-statistic-history-usage-nothing-display').show();
 				}
 				$('#hp-module-statistic-history-usage').show();

 				if (page <= 1) {
 					$('.paginate_button.previous').addClass('disabled');
 				}
 				else {
 					$('.paginate_button.previous').removeClass('disabled');
 				}

 				if (data.length == 21) {
 					$('.paginate_button.next').removeClass('disabled');
 				}
 				else {
 					$('.paginate_button.next').addClass('disabled');
 				}
            });
 		}

     	$(document).ready(function() {
     		getPageStatistic(page);

     		$('.paginate_button.previous a').on("click", function() {
	     		if (!$('.paginate_button.previous').is('.disabled')) {
	     			getPageStatistic(page = page - 1);
	     		}
	     	});

	     	$('.paginate_button.next a').on("click", function() {
	     		if (!$('.paginate_button.next').is('.disabled')) {
	     			getPageStatistic(page = page + 1);
	     		}
	     	});
     	});
     {/literal}
     </script>
</div>
{*hostpro start*}
{if $enablebackup}
<div class="tab-pane" id="tabModuleBackups">
    {*<h3>{$LANG.clientAreaBackupTitle}</h3>*}
    <div id="resultBackups"></div>
    <div class="row">
        <button onclick="actionBackups('list');return false" type="button" class="btn btn-success">{$LANG.clientAreaFindBackup}</button>
    </div>

    <script type="text/javascript">
    {literal}
        function actionBackups(action, day = '') {
            var dataSend = {action: action, pid: $('input[name="id"]').val()};
            if (day) {
                 dataSend.snapshot = day;
            }
            $.ajax({
                data: dataSend,
                type: 'POST',
                url: "/custom/api/backups.php", 
                success: function(result) {
                    if (result['status'] === 'success') {
                        showResultBackups(action, result['data']);
                    }
                }
            });
        }
        function showResultBackups(action, data)
        {
            var response = '';
            if (action === 'list') {
                response += '<table class="table table-list"><thead><tr><th>Day</th><th>Date</th><th>Restore</th></tr>';
                for (day in data) {
                    response += '<tr><td>' + day + '</td><td>' + data[day] + '</td><td><button onclick="actionBackups(\'restore\', \'' + day + '\');return false" type="button" class="btn btn-primary btn-lg"><i class="fa fa-window-restore"></i></button></td></tr>';
                }
                response += '</tbody></table>';
            } else if (action === 'restore') {
                response = '<div class="alert alert-info"><button type="button" class="close" data-dismiss="alert">×</button>'
                response += 'Recovery is successful</div>'
            }
            $('#resultBackups').html(response);
        }
    {/literal}
    </script>
</div>
{/if}
{if $groupname == "SSL-сертификаты"}
<!-- CSR Generator-->
<div data-toggle="tab" id="tabSSL" class="tab-pane">
<div class="row">
   <div class="col-md-12">
    <h2 class="page-header">CSR Generator</h2>
    {$LANG.sslcsrgeneratordiscription}
   </div>
</div>

<div class="clear">&nbsp;</div>

<div class="clear">&nbsp;</div>
<div class="container">
<div class="alert alert-info" role="alert"><i class="fa fa-warning"></i> {$LANG.sslwarning}</div>
  <div class="row">
<form action=""  method="post"  class="form-horizontal">
                            <div class="form-group">
                               <label class="control-label col-sm-2" >{$LANG.ssldomain}</label>
                               <div class="input-group st-input col-sm-6">
                               <span class="input-group-addon input-group-addon-2"><i class="icon-lock"></i> https://</span><input id="commonName" class="form-control" id="prependedInput"  type="text" placeholder=" example.com или *.example.com" style="width: 460px !important;">
                               </div>
                            </div>
                            <div class="form-group">
                               <label class="control-label col-sm-2" >{$LANG.sslorganization}</label>
                               <div class="input-group st-input col-sm-6">
                                   <input id="organizationName" class="" style="width: 550px !important;" id="prependedInput"  type="text" placeholder=" MyCompany">
                               </div>
                            </div>
                            <div class="form-group">
                               <label class="control-label col-sm-2" >{$LANG.ssldepartment}</label>
                               <div class="input-group st-input col-sm-6">
                                   <input id="organizationalUnitName" class=" " id="prependedInput"  style="width: 550px !important;" type="text" placeholder=" IT">
                               </div>
                            </div>
                            <div class="form-group">
                               <label class="control-label col-sm-2" >{$LANG.sslcity}</label>
                               <div class="input-group st-input col-sm-6">
                                   <input id="localityName" class=" " id="prependedInput" style="width: 550px !important;" type="text" placeholder=" Kyiv">
                               </div>
                            </div>
                            <div class="form-group">
                               <label class="control-label col-sm-2" >{$LANG.sslregion}</label>
                               <div class="input-group st-input col-sm-6">
                                   <input id="stateOrProvinceName" class=" " style="width: 550px !important;" id="prependedInput"  type="text" placeholder=" Kyivska Oblast">
                               </div>
                            </div>
                            <div class="form-group">
                               <label class="control-label col-sm-2" for="country">{$LANG.sslcountry}</label>
                               <div class="input-group st-input st-input-select">

                                   <select id="country">
<option label="UA Украина" value="UA">UA Украина</option>
<option label="RU Россия" value="RU">RU Россия</option>
<option label="BY Белоруссия" value="BY">BY Белоруссия</option>
<option label="AF Afghanistan" value="AF">AF Afghanistan</option>
<option label="AX Aland Islands" value="AX">AX Aland Islands</option>
<option label="AL Albania" value="AL">AL Albania</option>
<option label="DZ Algeria" value="DZ">DZ Algeria</option>
<option label="AS American Samoa" value="AS">AS American Samoa</option>
<option label="AD Andorra" value="AD">AD Andorra</option>
<option label="AO Angola" value="AO">AO Angola</option>
<option label="AI Anguilla" value="AI">AI Anguilla</option>
<option label="AQ Antarctica" value="AQ">AQ Antarctica</option>
<option label="AG Antigua And Barbuda" value="AG">AG Antigua And Barbuda</option>
<option label="AR Argentina" value="AR">AR Argentina</option>
<option label="AM Armenia" value="AM">AM Armenia</option>
<option label="AW Aruba" value="AW">AW Aruba</option>
<option label="AU Australia" value="AU">AU Australia</option>
<option label="AT Austria" value="AT">AT Austria</option>
<option label="AZ Azerbaijan" value="AZ">AZ Azerbaijan</option>
<option label="BS Bahamas" value="BS">BS Bahamas</option>
<option label="BH Bahrain" value="BH">BH Bahrain</option>
<option label="BD Bangladesh" value="BD">BD Bangladesh</option>
<option label="BB Barbados" value="BB">BB Barbados</option>
<option label="BE Belgium" value="BE">BE Belgium</option>
<option label="BZ Belize" value="BZ">BZ Belize</option>
<option label="BJ Benin" value="BJ">BJ Benin</option>
<option label="BM Bermuda" value="BM">BM Bermuda</option>
<option label="BT Bhutan" value="BT">BT Bhutan</option>
<option label="BO Bolivia" value="BO">BO Bolivia</option>
<option label="BA Bosnia And Herzegovina" value="BA">BA Bosnia And Herzegovina</option>
<option label="BW Botswana" value="BW">BW Botswana</option>
<option label="BV Bouvet Island" value="BV">BV Bouvet Island</option>
<option label="BR Brazil" value="BR">BR Brazil</option>
<option label="IO British Indian Ocean Territory" value="IO">IO British Indian Ocean Territory</option>
<option label="BN Brunei Darussalam" value="BN">BN Brunei Darussalam</option>
<option label="BG Bulgaria" value="BG">BG Bulgaria</option>
<option label="BF Burkina Faso" value="BF">BF Burkina Faso</option>
<option label="BI Burundi" value="BI">BI Burundi</option>
<option label="KH Cambodia" value="KH">KH Cambodia</option>
<option label="CM Cameroon" value="CM">CM Cameroon</option>
<option label="CA Canada" value="CA">CA Canada</option>
<option label="CV Cape Verde" value="CV">CV Cape Verde</option>
<option label="KY Cayman Islands" value="KY">KY Cayman Islands</option>
<option label="CF Central African Republic" value="CF">CF Central African Republic</option>
<option label="TD Chad" value="TD">TD Chad</option>
<option label="CL Chile" value="CL">CL Chile</option>
<option label="CN China" value="CN">CN China</option>
<option label="CX Christmas Island" value="CX">CX Christmas Island</option>
<option label="CC Cocos (Keeling) Islands" value="CC">CC Cocos (Keeling) Islands</option>
<option label="CO Colombia" value="CO">CO Colombia</option>
<option label="KM Comoros" value="KM">KM Comoros</option>
<option label="CG Congo" value="CG">CG Congo</option>
<option label="CD Congo, Democratic Republic" value="CD">CD Congo, Democratic Republic</option>
<option label="CK Cook Islands" value="CK">CK Cook Islands</option>
<option label="CR Costa Rica" value="CR">CR Costa Rica</option>
<option label="CI Cote D'Ivoire" value="CI">CI Cote D'Ivoire</option>
<option label="HR Croatia" value="HR">HR Croatia</option>
<option label="CU Cuba" value="CU">CU Cuba</option>
<option label="CY Cyprus" value="CY">CY Cyprus</option>
<option label="CZ Czech Republic" value="CZ">CZ Czech Republic</option>
<option label="DK Denmark" value="DK">DK Denmark</option>
<option label="DJ Djibouti" value="DJ">DJ Djibouti</option>
<option label="DM Dominica" value="DM">DM Dominica</option>
<option label="DO Dominican Republic" value="DO">DO Dominican Republic</option>
<option label="EC Ecuador" value="EC">EC Ecuador</option>
<option label="EG Egypt" value="EG">EG Egypt</option>
<option label="SV El Salvador" value="SV">SV El Salvador</option>
<option label="GQ Equatorial Guinea" value="GQ">GQ Equatorial Guinea</option>
<option label="ER Eritrea" value="ER">ER Eritrea</option>
<option label="EE Estonia" value="EE">EE Estonia</option>
<option label="ET Ethiopia" value="ET">ET Ethiopia</option>
<option label="FK Falkland Islands (Malvinas)" value="FK">FK Falkland Islands (Malvinas)</option>
<option label="FO Faroe Islands" value="FO">FO Faroe Islands</option>
<option label="FJ Fiji" value="FJ">FJ Fiji</option>
<option label="FI Finland" value="FI">FI Finland</option>
<option label="FR France" value="FR">FR France</option>
<option label="GF French Guiana" value="GF">GF French Guiana</option>
<option label="PF French Polynesia" value="PF">PF French Polynesia</option>
<option label="TF French Southern Territories" value="TF">TF French Southern Territories</option>
<option label="GA Gabon" value="GA">GA Gabon</option>
<option label="GM Gambia" value="GM">GM Gambia</option>
<option label="GE Georgia" value="GE">GE Georgia</option>
<option label="DE Germany" value="DE">DE Germany</option>
<option label="GH Ghana" value="GH">GH Ghana</option>
<option label="GI Gibraltar" value="GI">GI Gibraltar</option>
<option label="GR Greece" value="GR">GR Greece</option>
<option label="GL Greenland" value="GL">GL Greenland</option>
<option label="GD Grenada" value="GD">GD Grenada</option>
<option label="GP Guadeloupe" value="GP">GP Guadeloupe</option>
<option label="GU Guam" value="GU">GU Guam</option>
<option label="GT Guatemala" value="GT">GT Guatemala</option>
<option label="GG Guernsey" value="GG">GG Guernsey</option>
<option label="GN Guinea" value="GN">GN Guinea</option>
<option label="GW Guinea-Bissau" value="GW">GW Guinea-Bissau</option>
<option label="GY Guyana" value="GY">GY Guyana</option>
<option label="HT Haiti" value="HT">HT Haiti</option>
<option label="HM Heard Island &amp; Mcdonald Islands" value="HM">HM Heard Island &amp; Mcdonald Islands</option>
<option label="VA Holy See (Vatican City State)" value="VA">VA Holy See (Vatican City State)</option>
<option label="HN Honduras" value="HN">HN Honduras</option>
<option label="HK Hong Kong" value="HK">HK Hong Kong</option>
<option label="HU Hungary" value="HU">HU Hungary</option>
<option label="IS Iceland" value="IS">IS Iceland</option>
<option label="IN India" value="IN">IN India</option>
<option label="ID Indonesia" value="ID">ID Indonesia</option>
<option label="IR Iran, Islamic Republic Of" value="IR">IR Iran, Islamic Republic Of</option>
<option label="IQ Iraq" value="IQ">IQ Iraq</option>
<option label="IE Ireland" value="IE">IE Ireland</option>
<option label="IM Isle Of Man" value="IM">IM Isle Of Man</option>
<option label="IL Israel" value="IL">IL Israel</option>
<option label="IT Italy" value="IT">IT Italy</option>
<option label="JM Jamaica" value="JM">JM Jamaica</option>
<option label="JP Japan" value="JP">JP Japan</option>
<option label="JE Jersey" value="JE">JE Jersey</option>
<option label="JO Jordan" value="JO">JO Jordan</option>
<option label="KZ Kazakhstan" value="KZ">KZ Kazakhstan</option>
<option label="KE Kenya" value="KE">KE Kenya</option>
<option label="KI Kiribati" value="KI">KI Kiribati</option>
<option label="KR Korea" value="KR">KR Korea</option>
<option label="KW Kuwait" value="KW">KW Kuwait</option>
<option label="KG Kyrgyzstan" value="KG">KG Kyrgyzstan</option>
<option label="LA Lao People's Democratic Republic" value="LA">LA Lao People's Democratic Republic</option>
<option label="LV Latvia" value="LV">LV Latvia</option>
<option label="LB Lebanon" value="LB">LB Lebanon</option>
<option label="LS Lesotho" value="LS">LS Lesotho</option>
<option label="LR Liberia" value="LR">LR Liberia</option>
<option label="LY Libyan Arab Jamahiriya" value="LY">LY Libyan Arab Jamahiriya</option>
<option label="LI Liechtenstein" value="LI">LI Liechtenstein</option>
<option label="LT Lithuania" value="LT">LT Lithuania</option>
<option label="LU Luxembourg" value="LU">LU Luxembourg</option>
<option label="MO Macao" value="MO">MO Macao</option>
<option label="MK Macedonia" value="MK">MK Macedonia</option>
<option label="MG Madagascar" value="MG">MG Madagascar</option>
<option label="MW Malawi" value="MW">MW Malawi</option>
<option label="MY Malaysia" value="MY">MY Malaysia</option>
<option label="MV Maldives" value="MV">MV Maldives</option>
<option label="ML Mali" value="ML">ML Mali</option>
<option label="MT Malta" value="MT">MT Malta</option>
<option label="MH Marshall Islands" value="MH">MH Marshall Islands</option>
<option label="MQ Martinique" value="MQ">MQ Martinique</option>
<option label="MR Mauritania" value="MR">MR Mauritania</option>
<option label="MU Mauritius" value="MU">MU Mauritius</option>
<option label="YT Mayotte" value="YT">YT Mayotte</option>
<option label="MX Mexico" value="MX">MX Mexico</option>
<option label="FM Micronesia, Federated States Of" value="FM">FM Micronesia, Federated States Of</option>
<option label="MD Moldova" value="MD">MD Moldova</option>
<option label="MC Monaco" value="MC">MC Monaco</option>
<option label="MN Mongolia" value="MN">MN Mongolia</option>
<option label="ME Montenegro" value="ME">ME Montenegro</option>
<option label="MS Montserrat" value="MS">MS Montserrat</option>
<option label="MA Morocco" value="MA">MA Morocco</option>
<option label="MZ Mozambique" value="MZ">MZ Mozambique</option>
<option label="MM Myanmar" value="MM">MM Myanmar</option>
<option label="NA Namibia" value="NA">NA Namibia</option>
<option label="NR Nauru" value="NR">NR Nauru</option>
<option label="NP Nepal" value="NP">NP Nepal</option>
<option label="NL Netherlands" value="NL">NL Netherlands</option>
<option label="AN Netherlands Antilles" value="AN">AN Netherlands Antilles</option>
<option label="NC New Caledonia" value="NC">NC New Caledonia</option>
<option label="NZ New Zealand" value="NZ">NZ New Zealand</option>
<option label="NI Nicaragua" value="NI">NI Nicaragua</option>
<option label="NE Niger" value="NE">NE Niger</option>
<option label="NG Nigeria" value="NG">NG Nigeria</option>
<option label="NU Niue" value="NU">NU Niue</option>
<option label="NF Norfolk Island" value="NF">NF Norfolk Island</option>
<option label="MP Northern Mariana Islands" value="MP">MP Northern Mariana Islands</option>
<option label="NO Norway" value="NO">NO Norway</option>
<option label="OM Oman" value="OM">OM Oman</option>
<option label="PK Pakistan" value="PK">PK Pakistan</option>
<option label="PW Palau" value="PW">PW Palau</option>
<option label="PS Palestinian Territory, Occupied" value="PS">PS Palestinian Territory, Occupied</option>
<option label="PA Panama" value="PA">PA Panama</option>
<option label="PG Papua New Guinea" value="PG">PG Papua New Guinea</option>
<option label="PY Paraguay" value="PY">PY Paraguay</option>
<option label="PE Peru" value="PE">PE Peru</option>
<option label="PH Philippines" value="PH">PH Philippines</option>
<option label="PN Pitcairn" value="PN">PN Pitcairn</option>
<option label="PL Poland" value="PL">PL Poland</option>
<option label="PT Portugal" value="PT">PT Portugal</option>
<option label="PR Puerto Rico" value="PR">PR Puerto Rico</option>
<option label="QA Qatar" value="QA">QA Qatar</option>
<option label="RE Reunion" value="RE">RE Reunion</option>
<option label="RO Romania" value="RO">RO Romania</option>
<option label="RW Rwanda" value="RW">RW Rwanda</option>
<option label="BL Saint Barthelemy" value="BL">BL Saint Barthelemy</option>
<option label="SH Saint Helena" value="SH">SH Saint Helena</option>
<option label="KN Saint Kitts And Nevis" value="KN">KN Saint Kitts And Nevis</option>
<option label="LC Saint Lucia" value="LC">LC Saint Lucia</option>
<option label="MF Saint Martin" value="MF">MF Saint Martin</option>
<option label="PM Saint Pierre And Miquelon" value="PM">PM Saint Pierre And Miquelon</option>
<option label="VC Saint Vincent And Grenadines" value="VC">VC Saint Vincent And Grenadines</option>
<option label="WS Samoa" value="WS">WS Samoa</option>
<option label="SM San Marino" value="SM">SM San Marino</option>
<option label="ST Sao Tome And Principe" value="ST">ST Sao Tome And Principe</option>
<option label="SA Saudi Arabia" value="SA">SA Saudi Arabia</option>
<option label="SN Senegal" value="SN">SN Senegal</option>
<option label="RS Serbia" value="RS">RS Serbia</option>
<option label="SC Seychelles" value="SC">SC Seychelles</option>
<option label="SL Sierra Leone" value="SL">SL Sierra Leone</option>
<option label="SG Singapore" value="SG">SG Singapore</option>
<option label="SK Slovakia" value="SK">SK Slovakia</option>
<option label="SI Slovenia" value="SI">SI Slovenia</option>
<option label="SB Solomon Islands" value="SB">SB Solomon Islands</option>
<option label="SO Somalia" value="SO">SO Somalia</option>
<option label="ZA South Africa" value="ZA">ZA South Africa</option>
<option label="GS South Georgia And Sandwich Isl." value="GS">GS South Georgia And Sandwich Isl.</option>
<option label="ES Spain" value="ES">ES Spain</option>
<option label="LK Sri Lanka" value="LK">LK Sri Lanka</option>
<option label="SD Sudan" value="SD">SD Sudan</option>
<option label="SR Suriname" value="SR">SR Suriname</option>
<option label="SJ Svalbard And Jan Mayen" value="SJ">SJ Svalbard And Jan Mayen</option>
<option label="SZ Swaziland" value="SZ">SZ Swaziland</option>
<option label="SE Sweden" value="SE">SE Sweden</option>
<option label="CH Switzerland" value="CH">CH Switzerland</option>
<option label="SY Syrian Arab Republic" value="SY">SY Syrian Arab Republic</option>
<option label="TW Taiwan" value="TW">TW Taiwan</option>
<option label="TJ Tajikistan" value="TJ">TJ Tajikistan</option>
<option label="TZ Tanzania" value="TZ">TZ Tanzania</option>
<option label="TH Thailand" value="TH">TH Thailand</option>
<option label="TL Timor-Leste" value="TL">TL Timor-Leste</option>
<option label="TG Togo" value="TG">TG Togo</option>
<option label="TK Tokelau" value="TK">TK Tokelau</option>
<option label="TO Tonga" value="TO">TO Tonga</option>
<option label="TT Trinidad And Tobago" value="TT">TT Trinidad And Tobago</option>
<option label="TN Tunisia" value="TN">TN Tunisia</option>
<option label="TR Turkey" value="TR">TR Turkey</option>
<option label="TM Turkmenistan" value="TM">TM Turkmenistan</option>
<option label="TC Turks And Caicos Islands" value="TC">TC Turks And Caicos Islands</option>
<option label="TV Tuvalu" value="TV">TV Tuvalu</option>
<option label="UG Uganda" value="UG">UG Uganda</option>
<option label="AE United Arab Emirates" value="AE">AE United Arab Emirates</option>
<option label="GB United Kingdom" value="GB">GB United Kingdom</option>
<option label="US United States" value="US">US United States</option>
<option label="UM United States Outlying Islands" value="UM">UM United States Outlying Islands</option>
<option label="UY Uruguay" value="UY">UY Uruguay</option>
<option label="UZ Uzbekistan" value="UZ">UZ Uzbekistan</option>
<option label="VU Vanuatu" value="VU">VU Vanuatu</option>
<option label="VE Venezuela" value="VE">VE Venezuela</option>
<option label="VN Viet Nam" value="VN">VN Viet Nam</option>
<option label="VG Virgin Islands, British" value="VG">VG Virgin Islands, British</option>
<option label="VI Virgin Islands, U.S." value="VI">VI Virgin Islands, U.S.</option>
<option label="WF Wallis And Futuna" value="WF">WF Wallis And Futuna</option>
<option label="EH Western Sahara" value="EH">EH Western Sahara</option>
<option label="YE Yemen" value="YE">YE Yemen</option>
<option label="ZM Zambia" value="ZM">ZM Zambia</option>
<option label="ZW Zimbabwe" value="ZW">ZW Zimbabwe</option>

                                </select></span>
                           </div>
                          </div>
                          <div class="form-group">
                            <label  class="control-label col-sm-2" for="mail">Email</label>
                            <div class="input-group st-input col-sm-6">
                                <input type="text" class="inp-x" id="mail" value="" style="width: 550px !important;">
                            </div>
                          </div>
                        	<div class="input-group">

<!--                                 <label  class="checkbox inline" for="check-f" class="send-f">
                                   <input type="checkbox" id="check-f" value="1" name="sendmail" >  Отправить CSR и приватный ключ (RSA) на указанный адрес
-->
                            </div>
                        	<div class="clear"></div><br>
                          <div class="form-group">
                            <div class="form-actions col-sm-offset-2 col-sm-6">
                                <button id="generate" onclick="loadkeys();return false" type="submit" class="btn btn-success">Сгенерировать CSR</button>
                            </div>
                          </div>
			{literal}
				<script type='text/javascript'>
					function loadkeys() {
						if ($('#organizationName').val()=='' || $('#country').val()=='' || $('#stateOrProvinceName').val()=='' || $('#localityName').val()=='' || $('#organizationalUnitName').val()=='' || $('#commonName').val()=='' || $('#mail').val()=='') alert('Вам необходимо заполнить все поля.');
						else $('#keys').load('/generatecsr.php?id={/literal}{$id}{literal}&organizationName=' + encodeURIComponent($('#organizationName').val()) + '&country=' + encodeURIComponent($('#country').val()) + '&stateOrProvinceName=' + encodeURIComponent($('#stateOrProvinceName').val()) + '&localityName=' + encodeURIComponent($('#localityName').val()) + '&organizationalUnitName=' + encodeURIComponent($('#organizationalUnitName').val()) + '&commonName=' + encodeURIComponent($('#commonName').val()) + '&mail=' + encodeURIComponent($('#mail').val()));
					}
				</script>
			{/literal}

                    </form>
<div id="keys"></div>
</div>
</div>
</div>
{/if}
{*hostpro end*}
</div>


{* uniweb end *}
