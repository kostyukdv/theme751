<link href="modules/servers/cpanel/css/client.css" rel="stylesheet">
<script src="modules/servers/cpanel/js/client.js"></script>
{* hostpro start*}
{if $pid == "1124"} 
<div class="row">
     <div class="col-md-6">
        <div class="panel panel-default" id="cPanelPackagePanel">
            <div class="panel-heading">
                <h3 class="panel-title">{$LANG.cPanel.packageDomain} - {$domain}</h3>
            </div>
            <div class="panel-body text-left">

                <div class="cpanel-package-details">
                    <em>{$groupname}</em>
                    <h4 style="margin:0;">{$product}</h4>
                    <a href="http://{$domain}" target="_blank">www.{$domain}</a>
                </div>

                <p>
                    <a href="http://{$domain}" class="btn btn-default btn-sm" target="_blank">{$LANG.visitwebsite}</a>
                    {if $domainId}
                        <a href="clientarea.php?action=domaindetails&id={$domainId}" class="btn btn-success btn-sm" target="_blank">{$LANG.managedomain}</a>
                    {/if}
                    <input type="button" onclick="popupWindow('whois.php?domain={$domain}','whois',650,420);return false;" value="{$LANG.whoisinfo}" class="btn btn-info btn-sm" />
                </p>

            </div>
        </div>
      </div>
    <div class="col-md-6">

        <div class="panel panel-default" id="cPanelUsagePanel">
            <div class="panel-heading">
                <h3 class="panel-title">{$LANG.cPanel.usageStats}</h3>
            </div>
            <div class="panel-body text-center cpanel-usage-stats">

                <div class="row">
                    <div class="col-sm-5 col-sm-offset-1 col-xs-6" id="diskUsage">
                        <strong>{$LANG.cPanel.diskUsage}</strong>
                        <br /><br />
                        <input type="text" value="{$diskpercent|substr:0:-1}" class="usage-dial" data-fgColor="#5dd0ed" data-bgColor="#999" data-angleOffset="-125" data-angleArc="250" data-min="0" data-max="100" data-readOnly="true" data-width="100" data-height="80" />
                        <br /><br />
                        {$diskusage} M / {$disklimit} M
                    </div>
                </div>
             </div>
        </div>
                <script src="{$BASE_PATH_JS}/jquery.knob.js"></script>
                <script type="text/javascript">
                jQuery(function() {
                    jQuery(".usage-dial").knob({
                        'format': function (value) {
                            return value + '%';
                        }
                    });
                });
                </script>
     </div> 
</div>               
        <div class="panel panel-default" id="cPanelQuickShortcutsPanel">
        <div class="panel-heading">
            <h3 class="panel-title">{$LANG.cPanel.quickShortcuts}</h3>
        </div>
        <div class="panel-body text-center">

            <div class="row cpanel-feature-row">
                <div class="col-sm-2 col-xs-6" id="cPanelEmailAccounts">
                    <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Email_Accounts" target="_blank">
                        <img src="modules/servers/cpanel/img/email_accounts.png" />
                        {$LANG.cPanel.emailAccounts}
                    </a>
                </div>
                <div class="col-sm-2 col-xs-6" id="cPanelForwarders">
                    <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Email_Forwarders" target="_blank">
                        <img src="modules/servers/cpanel/img/forwarders.png" />
                        {$LANG.cPanel.forwarders}
                    </a>
                </div>
                <div class="col-sm-2 col-xs-6" id="cPanelAutoResponders">
                    <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Email_AutoResponders" target="_blank">
                        <img src="modules/servers/cpanel/img/autoresponders.png" />
                        {$LANG.cPanel.autoresponders}
                    </a>
                </div>
                <div class="col-sm-2 col-xs-6" id="cPanelBackup">
                    <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Backups_Home" target="_blank">
                        <img src="modules/servers/cpanel/img/backup.png" />
                        {$LANG.cPanel.backup}
                    </a>
                </div>
                <div class="col-sm-2 col-xs-6" id="cPanelAwstats">
                    <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Stats_AWStats" target="_blank">
                        <img src="modules/servers/cpanel/img/awstats.png" />
                        {$LANG.cPanel.awstats}
                    </a>
                </div>
                <div class="col-sm-2 col-xs-6" id="LetsEncrypt">
                    <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Security_letsencrypt" target="_blank">
                        <img src="modules/servers/cpanel/img/letsencrypt.png" />
                        Lets Encrypt™ SSL
                    </a>
                </div>
            </div>

        </div>
    </div>
        <div class="panel panel-default" id="cPanelQuickEmailPanel">
        <div class="panel-heading">
            <h3 class="panel-title">{$LANG.cPanel.createEmailAccount}</h3>
        </div>
        <div class="panel-body">

            {include file="$template/includes/alert.tpl" type="success" msg=$LANG.cPanel.emailAccountCreateSuccess textcenter=true hide=true idname="emailCreateSuccess" additionalClasses="email-create-feedback"}

            {include file="$template/includes/alert.tpl" type="danger" msg=$LANG.cPanel.emailAccountCreateFailed|cat:' <span id="emailCreateFailedErrorMsg"></span>' textcenter=true hide=true idname="emailCreateFailed" additionalClasses="email-create-feedback"}

            <form id="frmCreateEmailAccount" onsubmit="doEmailCreate();return false">
                <input type="hidden" name="id" value="{$serviceid}" />
                <input type="hidden" name="email_quota" value="250" />
                <div class="row">
                    <div class="col-sm-6">
                        <div class="input-group">
                            <input type="text" name="email_prefix" class="form-control" placeholder="{$LANG.cPanel.usernamePlaceholder}">
                            <span class="input-group-addon">@{$domain}</span>
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <input type="password" name="email_pw" class="form-control" placeholder="{$LANG.cPanel.passwordPlaceholder}">
                    </div>
                    <div class="col-sm-3">
                        <button type="submit" class="btn btn-primary btn-block" />
                            <i class="fa fa-plus" id="btnCreateLoader"></i>
                            {$LANG.cPanel.create}
                        </button>
                    </div>
                </div>
            </form>

        </div>
    </div>
        
        
{/if}
{if $groupname eq "Wordpress Хостинг" || $groupname eq "Wordpress Hosting"}

<div class="product-details clearfix"  style="background: #545d6b url('/templates/{$template}/assets/img/pattern-grey.svg') 0 0 repeat;" >
            <div class="row">
                <div class="col-md-6 text-center">
                    <div class="product-icon">
                            <i class="fa fa-wordpress fa-3x fa-inverse"></i>
                        <h4 style="color: #fff;">{$product} - {$domain}<span class="label label-default label-{$status|strtolower}">{$status}</span></h4>
                        <h4><small style="color: #fff;">{$groupname}</small></h4>
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
                    <div class="col-md-6 product-extra" style="color: #fff;">
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
              </div>
          </div>
{foreach $hookOutput as $output}
          <div>
            {$output}
        </div>
        {/foreach}
{* hostpro start *}
<br>
<script src="https://billing.hostpro.ua/elastic/highstock.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<div class="panel panel-default" id="cPanelQuickShortcutsPanel">
<div class="panel-heading">
    <h3 class="panel-title">Использовано ресурсов</h3>
</div>
<div class="row clearfix">
<div class="col-md-4 col-sm-12" style="border-right: 1px solid #ddd;">
<div class="" >
<div class="panel-body text-left">
<h4><i class="fa fa-folder-o"></i> {$LANG.diskSpace}</h4>
<small></small>
   <p id="hp-module-statistic-diskusage"></p>
   <div class="progress" style="height: 20px !important;">
     <div id="hp-module-statistic-diskusage-bar" class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuemin="0" aria-valuemax="100">
    </div>
   </div>
   <p><a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=FileManager_Home" target=_blank>Просмотреть список файлов</a></p>
<h4><i class="fa fa-database"></i> {$LANG.MysqlUsage}</h4>
   <p id="hp-module-statistic-database"></p>
   <div class="progress" style="height: 20px !important;">
     <div id="hp-module-statistic-database-bar" class="progress-bar progress-bar-info progress-bar-striped" role="progressbar" aria-valuemin="0" aria-valuemax="100">
    </div>
   </div>
<div  class="clear"></div>
</div>
</div>
</div>

<script type="text/javascript">
     {literal}
      $(document).ready(function() {
        jQuery.getJSON('https://billing.hostpro.ua/elastic/database_storage.php?id={/literal}{$id}{literal}', function(data) {

          var disklimit = {/literal}{$disklimit}{literal},
            diskpersent = Math.round(data['storage'] * 100 / disklimit),
            databasepersent = Math.round(data['mysql'] * 100 / disklimit);

          $('#hp-module-statistic-database').text(data['mysql']+" MB");
          $('#hp-module-statistic-diskusage').text(data['storage']+"MB / "+disklimit+" MB");
          $('#hp-module-statistic-diskusage-bar').attr('aria-valuenow', diskpersent).css('width', diskpersent+'%');
          $('#hp-module-statistic-database-bar').attr('aria-valuenow', databasepersent).css('width', databasepersent+'%');
            });
      });

      $(document).ready(function() {
        jQuery.getJSON('https://billing.hostpro.ua/elastic/usage.php?id={/literal}{$id}{literal}', function(data) {
          if (data != undefined) {
            $('#hp-module-statistic-usage').show();
            $('#hp-module-statistic-storage').text(data['storage']+" GB ($"+data['amount_storage']+")");
            $('#hp-module-statistic-cpu').text(data['apcpu']+" % ($"+data['amount_cpu']+")");
            $('#hp-module-statistic-pmem').text(data['apmem']+" MB ($"+data['amount_mem']+")");
          }
          else{
            $('hp-module-statistic-usage-nothing-display').show();
          }
            });
      });
     {/literal}
     </script>

<div class="col-md-8 col-sm-12">
<div  class="">
<div class="panel-body text-left">
<h4><i class="fa fa-server"></i> {$LANG.MemUsage}</h4>
<small></small>
        <div class="">
            <script type="text/javascript">
            var example = 'line-time-series',
                theme = 'default';
            </script>

            <script type="text/javascript">
            {literal}
                var chart;
                $(document).ready(function() {
                    var options = {
                        chart: {
                            renderTo: 'container2',
                            defaultSeriesType: 'area',
                            //marginRight: 130,
                            //marginBottom: 25,
                            spacingRight: 40,
                            spacingLeft: 0,
                            zoomType: 'x',
                            classname: 'col-md-12'
                        },
                        //title: {
                        //    text: 'Память',
                        //    x: 0 //center
                        //},
                        xAxis: {
                            type: 'datetime',
                            min: 0
                        },
                        yAxis: {
                            min: 0,
                            title: {
                                text: 'RAM, MB'
                            },
                            plotLines: [{
                                value: 8192,
                                width: 1,
                                dashStyle: 'shortdash',
                                color: 'red',
                                label: {
                                    text : 'Максимальный лимит'
                                }
                            }]
                        },
                        tooltip: {

                            formatter: function() {
                            return '' + Highcharts.dateFormat('%e. %b, %H:%M', this.x) +', <b>Память:</b> '+ this.y + ' MB';
                            }

                        },

                        legend: {
                            enabled: false
                            //  layout: 'horizontal',
                            //  align: 'right',
                            //  verticalAlign: 'top',
                            //  x: -10,
                            //  y: 10,
                            //  borderWidth: 0
                        },
                        credits : {
                                enabled : false
                        },
                        scrollbar: {
                                enabled: false
                        },
                        rangeSelector: {
                            buttonTheme: { // styles for the buttons
                                fill: 'none',
                                stroke: 'none',
                                'stroke-width': 0,
                                r: 10,
                                width: 40,
                                height: 18,
                                style: {
                                 color: '#039',
                                 fontWeight: 'bold'
                                },
                                states: {
                                 hover: {
                                 },
                                select: {
                                 fill: '#039',
                                 style: {
                                  color: 'white'
                                 }
                                }
                                // disabled: { ... }
                                }
                            },
                            inputEnabled: false,
                            buttonSpacing: 2,
                            selected: 0,
                            buttons: [{
                           //     type: 'hour',
                           //     count: 1,
                           //     text: '1ч'
                           // }, {
                                type: 'day',
                                count: 1,
                                text: '24ч'
                            }, {
                                type: 'week',
                                count: 1,
                                text: '1н'
                            }, {
                                type: 'month',
                                count: 1,
                                text: '1м'
                            }, {
                                type: 'all',
                                text: 'All'
                            }]
                        },
                        navigator: {
                            enabled: false
                        },
                        plotOptions: {
                            area: {
                               //    fillColor: {
                               //    linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1},
                               //    stops: [
                               //            [0, Highcharts.getOptions().colors[0]],
                               //            [1, 'rgba(3,0,0,0)']
                               //           ]
                               //    },
                               // lineWidth: 1,
                                marker: {
                                    enabled: false,
                                    states: {
                                        hover: {
                                            enabled: true,
                                            radius: 5
                                        }
                                    }
                                },
                                shadow: false,
                                states: {
                                    hover: {
                                        lineWidth: 1
                                    }
                                },
                                threshold: 0
                            }
                        },
                        series: [{
                            type: 'spline',
                            pointInterval: 24 * 3600 * 1000,
                            color: '#48A5E0',
                            lineWidth: 1
                        }]
                    }
                    // Load data asynchronously using jQuery. On success, add the data
                    // to the options and initiate the chart.
                    // This data is obtained by exporting a GA custom report to TSV.
                    // http://api.jquery.com/jQuery.get/
                    jQuery.get('https://billing.hostpro.ua/elastic/mem.php?id={/literal}{$id}{literal}', null, function(tsv) {
                        var lines = [];
                        traffic = [];
                        try {
                            // split the data return into lines and parse them
                            tsv = tsv.split(/\n/g);
                            jQuery.each(tsv, function(i, line) {
                                line = line.split(/\t/);
                                date = Date.parse(line[0] +' UTC');
                                                            traffic.push([
                                    date,
                                    parseInt(line[1].replace(',', ''), 10)
                                                            ]);
                            });
                        } catch (e) {  }
                        options.series[0].data = traffic;
                        chart = new Highcharts.StockChart(options);
                    });
                });
                {/literal}
            </script>
            <div id="container2" style="height: 200px; margin: 0 auto"></div>
        </div>
</div>
</div>
</div>
</div>
</div>
        <br>
        <div class="panel panel-default" id="cPanelQuickShortcutsPanel">
        <div class="panel-heading">
            <h3 class="panel-title">{$LANG.cPanel.quickShortcuts}</h3>
        </div>
        <div class="panel-body text-center">

            <div class="row cpanel-feature-row">
                <div class="col-sm-3 col-xs-6" id="cPanelEmailAccounts">
                    <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Email_Accounts" target="_blank">
                        <img src="modules/servers/cpanel/img/email_accounts.png" />
                        {$LANG.cPanel.emailAccounts}
                    </a>
                </div>
                <div class="col-sm-3 col-xs-6" id="cPanelAddonDomains">
                    <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Domains_AddonDomains" target="_blank">
                        <img src="modules/servers/cpanel/img/addon_domains.png" />
                        {$LANG.cPanel.addonDomains}
                    </a>
                </div>
                <div class="col-sm-3 col-xs-6" id="cPanelFileManager">
                    <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=FileManager_Home" target="_blank">
                        <img src="modules/servers/cpanel/img/file_manager.png" />
                        {$LANG.cPanel.fileManager}
                    </a>
                </div>
                <div class="col-sm-3 col-xs-6" id="cPanelFTP">
                    <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Ftp_Accounts" target="_blank">
                        <img src="modules/servers/cpanel/img/ftp.png" />
                        FTP Учётные записи
                    </a>
                </div>
              </div><br>
              <div class="row cpanel-feature-row">
                <div class="col-sm-3 col-xs-6" id="WordpressManager">
                    <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=WordPress" target="_blank">
                        <img src="modules/servers/cpanel/img/wp.png" />
                        Wordpress Manager
                    </a>
                </div>
                <div class="col-sm-3 col-xs-6" id="cPanelCronJobs">
                    <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Cron_Home" target="_blank">
                        <img src="modules/servers/cpanel/img/cron_jobs.png" />
                        {$LANG.cPanel.cronJobs}
                    </a>
                </div>
                <div class="col-sm-3 col-xs-6" id="LetsEncrypt">
                    <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Security_letsencrypt" target="_blank">
                        <img src="modules/servers/cpanel/img/letsencrypt.png" />
                        Lets Encrypt™ SSL
                    </a>
                </div>
                <div class="col-sm-3 col-xs-6" id="cPanelBackup">
                    <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Backups_Home" target="_blank">
                        <img src="modules/servers/cpanel/img/backup.png" />
                        {$LANG.cPanel.backup}
                    </a>
                </div>
            </div>

        </div>
    </div>
    {/if}
{* hostpro end *}

{if $product == "GuruHosting" || $product == "GuruHosting-Trial" || $product == "Guru-Dev"}
<script src="https://billing.hostpro.ua/elastic/highstock.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
 <div class="row">
  <div class="col-md-4 col-sm-12">
    <div class="panel panel-default" >
        <div class="panel-body text-left">
        <h4><i class="fa fa-folder-o"></i> {$LANG.diskSpace}</h4>
        
           <p id="hp-module-statistic-diskusage"></p>
           <div class="progress" style="height: 8px !important;">
             <div id="hp-module-statistic-diskusage-bar" class="progress-bar progress-bar-success" role="progressbar" aria-valuemin="0" aria-valuemax="100">
            </div>
           </div>
           <p><a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=FileManager_Home" target=_blank>Просмотреть список файлов</a></p> 
        <h4><i class="fa fa-database"></i> {$LANG.MysqlUsage}</h4> 
           <p id="hp-module-statistic-database"></p>
           <div class="progress" style="height: 8px !important;">
             <div id="hp-module-statistic-database-bar" class="progress-bar progress-bar-info" role="progressbar" aria-valuemin="0" aria-valuemax="100">
            </div>
           </div>
        
        <div  class="clear"></div>
    </div>
            
</div>
</div>
  <div class="col-md-4 col-sm-12">
              <div class="page-header"><h4><i class="fa fa-usd"></i> {$LANG.invoicescredit} 
                                           <span class="pull-right flip"><a href="clientarea.php?action=addfunds" class="btn btn-success">{$LANG.addfunds1}</a></span>
                                       </h4>
                <small>{$LANG.availcreditbaldesc}</small>
              </div>
              <ul class="list-group">
                <li class="list-group-item">
                  {$LANG.availcreditbal}<span class="pull-right flip">{$clientsstats.creditbalance}<span>
                </li>
                <li class="list-group-item">
                  {$LANG.clientareahostingnextduedate} <span class="pull-right flip">{$nextduedate}<span>
                </li>
              </ul>
  </div>
  <div class="col-md-4 col-sm-12">
              <div class="page-header"><h4><i class="fa fa-area-chart"></i> {$LANG.resourceUsage}</h4>
                <small>{$LANG.ordertotalduetoday}</small><span class="pull-right flip">
              </div>
              <div id="hp-module-statistic-usage" style="display:none;">
              <ul class="list-group">
                 <li class="list-group-item">      <div class="row">
                        <div class="col-xs-5 text-left"><i class="fa fa-folder-o"></i> {$LANG.diskSpace}</div>
                        <div class="col-xs-7" id="hp-module-statistic-storage"></div>
                    </div>
                 </li>
                 <li class="list-group-item"> 
                    <div class="row">
                        <div class="col-xs-5 text-left"><i class="fa fa-microchip"></i> {$LANG.CpuUsage}</div>
                        <div class="col-xs-7" id="hp-module-statistic-cpu"></div>
                    </div>
                 </li>
                 <li class="list-group-item">
                    <div class="row">
                        <div class="col-xs-5 text-left"><i class="fa fa-server"></i> {$LANG.MemUsage}</div>
                        <div class="col-xs-7" id="hp-module-statistic-pmem"></div>
                    </div>
                 </li>
              </ul>
              </div>
              <div id="hp-module-statistic-usage-nothing-display" style="display:none;">
              		<div class="col-xs-12 text-center">Nothing to Display</div>
              </div>
			
			 <script type="text/javascript">
             {literal}
             	$(document).ready(function() {
             		jQuery.getJSON('https://billing.hostpro.ua/elastic/database_storage.php?id={/literal}{$id}{literal}', function(data) {
             			
             			var disklimit = {/literal}{$disklimit}{literal},
             				diskpersent = Math.round(data['storage'] * 100 / disklimit),
             				databasepersent = Math.round(data['mysql'] * 100 / disklimit);
             			
             			$('#hp-module-statistic-database').text(data['mysql']+" MB");
             			$('#hp-module-statistic-diskusage').text(data['storage']+"MB / "+disklimit+" MB");
             			$('#hp-module-statistic-diskusage-bar').attr('aria-valuenow', diskpersent).css('width', diskpersent+'%');
             			$('#hp-module-statistic-database-bar').attr('aria-valuenow', databasepersent).css('width', databasepersent+'%');
                    });
             	});
             
             	$(document).ready(function() {
             		jQuery.getJSON('https://billing.hostpro.ua/elastic/usage.php?id={/literal}{$id}{literal}', function(data) {
             			if (data != undefined) {
             				$('#hp-module-statistic-usage').show();
	             			$('#hp-module-statistic-storage').text(data['storage']+" GB ($"+data['amount_storage']+")");
	             			$('#hp-module-statistic-cpu').text(data['apcpu']+" % ($"+data['amount_cpu']+")");
	             			$('#hp-module-statistic-pmem').text(data['apmem']+" MB ($"+data['amount_mem']+")");
             			}
             			else{
             				$('hp-module-statistic-usage-nothing-display').show();
             			}
                    });
             	});
             {/literal}
             </script>
 </div> 
 </div>
 <div class="row">
 <div class="col-md-6 col-sm-12">
  <div class="panel panel-default" >
            
    <div class="panel-body text-left">
    <h4><i class="fa fa-microchip"></i> {$LANG.CpuUsage} <a class="btn btn-outline-info btn-sm" data-original-title="{$LANG.cputooltip}">?</a></h4><small>x8 CPU</small>
        <div class="">
                    <script type="text/javascript">
                    var example = 'line-time-series',
                        theme = 'default';
                    </script>

                    <script type="text/javascript">
                    {literal}
                        var chart;
                        $(document).ready(function() {
                            var options = {
                                chart: {
                                    renderTo: 'container1',
                                    defaultSeriesType: 'area',
                                    //marginRight: 130,
                                    //marginBottom: 25,
                                    spacingRight: 40,
                                    spacingLeft: 0,
                                    zoomType: 'x',
                                    classname: 'col-md-12 col-sm-12'
                                },
                                //title: {
                                //    text: 'Процессор',
                                //    x: -20 //center
                                //},
                                xAxis: {
                                    type: 'datetime',
                                    min: 0
                                },
                                yAxis: {
                                    min: 0,
                                    title: {
                                        text: '% CPU'
                                    },
                                    plotLines: [{
                                        value: 200,
                                        width: 1,
                                        dashStyle: 'shortdash',
                                        color: 'red',
                                        label: {
                                            text : 'Максимальный лимит'
                                        }
                                    }]
                                },
                                tooltip: {
                                    formatter: function() {
                                        return '' + Highcharts.dateFormat('%e. %b, %H:%M', this.x) +', <b>CPU:</b> '+ this.y + ' %';   
                                    }
                                    
                                },
                                legend: {
                                    enabled: false
                                    //  layout: 'vertical',
                                    //  align: 'right',
                                    //  verticalAlign: 'top',
                                    //  x: -10,
                                    //  y: 100,
                                    //  borderWidth: 0
                                },
                                credits : {
                                        enabled : false
                                },
                                scrollbar: {
                                        enabled: false
                                },
                                rangeSelector: {
                                    buttonTheme: { // styles for the buttons
                                        fill: 'none',
                                        stroke: 'none',
                                        'stroke-width': 0,
                                        r: 10,
                                        width: 40,
                                        height: 18,
                                        style: {
                                         color: '#039',
                                         fontWeight: 'bold'
                                        },
                                        states: {
                                         hover: {
                                         },
                                        select: {
                                         fill: '#039',
                                         style: {
                                          color: 'white'
                                         }
                                        }
                                        // disabled: { ... }
                                        }
                                    },
                                    inputEnabled: false,
                                    buttonSpacing: 2,
                                    selected: 0,
                                    buttons: [{
                                        type: 'day',
                                        count: 1,
                                        text: '24ч'
                                    }, {
                                        type: 'week',
                                        count: 1,
                                        text: '1н'
                                    }, {
                                        type: 'month',
                                        count: 1,
                                        text: '1м'
                                    }, {
                                        type: 'all',
                                        text: 'All'
                                    }]
                                },
                                navigator: {
                                    enabled: false
                                },
                                plotOptions: {
                                    area: {
                                       //    fillColor: {
                                       //    linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1},
                                       //    stops: [
                                       //            [0, Highcharts.getOptions().colors[0]],
                                       //            [1, 'rgba(3,0,0,0)']
                                       //           ]
                                       //    },
                                       //    lineWidth: 1,
                                        marker: {
                                            enabled: false,
                                            states: {
                                                hover: {
                                                    enabled: true,
                                                    radius: 5
                                                }
                                            }
                                        },
                                        shadow: false,
                                        states: {
                                            hover: {
                                                lineWidth: 1
                                            }
                                        },
                                        threshold: 0
                                    }
                                },
                                series: [{
                                    type: 'spline',
                                    pointInterval: 24 * 3600 * 1000,
                                    color: '#00B2B5',
                                    lineWidth: 1
                                   }]
                            }
                            // Load data asynchronously using jQuery. On success, add the data
                            // to the options and initiate the chart.
                            // This data is obtained by exporting a GA custom report to TSV.
                            // http://api.jquery.com/jQuery.get/
                            jQuery.get('https://billing.hostpro.ua/elastic/cpu.php?id={/literal}{$id}{literal}', null, function(tsv) {
                                var lines = [];
                                traffic = [];
                                try {
                                    // split the data return into lines and parse them
                                    tsv = tsv.split(/\n/g);
                                    jQuery.each(tsv, function(i, line) {
                                        line = line.split(/\t/);
                                        date = Date.parse(line[0] +' UTC');
                                                                    traffic.push([
                                            date,
                                            parseInt(line[1].replace(',', ''), 10)
                                                                    ]);
                                    });
                                } catch (e) {  }
                                options.series[0].data = traffic;
                                chart = new Highcharts.StockChart(options);
                            });
                        });
                        {/literal}
                    </script>
                    <div id="container1" style="height: 250px; margin: 0 auto"></div>
                </div>
            </div>
 </div>
 </div>          
 <div class="col-md-6 col-sm-12">
  <div  class="panel panel-default">
            
    <div class="panel-body text-left">
    <h4><i class="fa fa-server"></i> {$LANG.MemUsage} <button class="btn btn-outline-info btn-sm" data-toggle="tooltip" data-placement="top" title="{$LANG.memtooltip}">?</button></h4>
    <small>Up to 8GB</small>
                <div class="">
                    <script type="text/javascript">
                    var example = 'line-time-series',
                        theme = 'default';
                    </script>

                    <script type="text/javascript">
                    {literal}
                        var chart;
                        $(document).ready(function() {
                            var options = {
                                chart: {
                                    renderTo: 'container2',
                                    defaultSeriesType: 'area',
                                    //marginRight: 130,
                                    //marginBottom: 25,
                                    spacingRight: 40,
                                    spacingLeft: 0,
                                    zoomType: 'x',
                                    classname: 'col-md-12'
                                },
                                //title: {
                                //    text: 'Память',
                                //    x: 0 //center
                                //},
                                xAxis: {
                                    type: 'datetime',
                                    min: 0
                                },
                                yAxis: {
                                    min: 0,
                                    title: {
                                        text: 'RAM, MB'
                                    },
                                    plotLines: [{
                                        value: 8192,
                                        width: 1,
                                        dashStyle: 'shortdash',
                                        color: 'red',
                                        label: {
                                            text : 'Максимальный лимит'
                                        }
                                    }]
                                },
                                tooltip: {
                                    
                                    formatter: function() {
                                    return '' + Highcharts.dateFormat('%e. %b, %H:%M', this.x) +', <b>Память:</b> '+ this.y + ' MB';   
                                    }
                                    
                                },
                                
                                legend: {
                                    enabled: false
                                    //  layout: 'horizontal',
                                    //  align: 'right',
                                    //  verticalAlign: 'top',
                                    //  x: -10,
                                    //  y: 10,
                                    //  borderWidth: 0
                                },
                                credits : {
                                        enabled : false
                                },
                                scrollbar: {
                                        enabled: false
                                },
                                rangeSelector: {
                                    buttonTheme: { // styles for the buttons
                                        fill: 'none',
                                        stroke: 'none',
                                        'stroke-width': 0,
                                        r: 10,
                                        width: 40,
                                        height: 18,
                                        style: {
                                         color: '#039',
                                         fontWeight: 'bold'
                                        },
                                        states: {
                                         hover: {
                                         },
                                        select: {
                                         fill: '#039',
                                         style: {
                                          color: 'white'
                                         }
                                        }
                                        // disabled: { ... }
                                        }
                                    },
                                    inputEnabled: false,
                                    buttonSpacing: 2,
                                    selected: 0,
                                    buttons: [{
                                   //     type: 'hour',
                                   //     count: 1,
                                   //     text: '1ч'
                                   // }, {
                                        type: 'day',
                                        count: 1,
                                        text: '24ч'
                                    }, {
                                        type: 'week',
                                        count: 1,
                                        text: '1н'
                                    }, {
                                        type: 'month',
                                        count: 1,
                                        text: '1м'
                                    }, {
                                        type: 'all',
                                        text: 'All'
                                    }]
                                },
                                navigator: {
                                    enabled: false
                                },
                                plotOptions: {
                                    area: {
                                       //    fillColor: {
                                       //    linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1},
                                       //    stops: [
                                       //            [0, Highcharts.getOptions().colors[0]],
                                       //            [1, 'rgba(3,0,0,0)']
                                       //           ]
                                       //    },
                                       // lineWidth: 1,
                                        marker: {
                                            enabled: false,
                                            states: {
                                                hover: {
                                                    enabled: true,
                                                    radius: 5
                                                }
                                            }
                                        },
                                        shadow: false,
                                        states: {
                                            hover: {
                                                lineWidth: 1
                                            }
                                        },
                                        threshold: 0
                                    }
                                },
                                series: [{
                                    type: 'spline',
                                    pointInterval: 24 * 3600 * 1000,
                                    color: '#48A5E0',
                                    lineWidth: 1
                                }]
                            }
                            // Load data asynchronously using jQuery. On success, add the data
                            // to the options and initiate the chart.
                            // This data is obtained by exporting a GA custom report to TSV.
                            // http://api.jquery.com/jQuery.get/
                            jQuery.get('https://billing.hostpro.ua/elastic/mem.php?id={/literal}{$id}{literal}', null, function(tsv) {
                                var lines = [];
                                traffic = [];
                                try {
                                    // split the data return into lines and parse them
                                    tsv = tsv.split(/\n/g);
                                    jQuery.each(tsv, function(i, line) {
                                        line = line.split(/\t/);
                                        date = Date.parse(line[0] +' UTC');
                                                                    traffic.push([
                                            date,
                                            parseInt(line[1].replace(',', ''), 10)
                                                                    ]);
                                    });
                                } catch (e) {  }
                                options.series[0].data = traffic;
                                chart = new Highcharts.StockChart(options);
                            });
                        });
                        {/literal}
                    </script>
                    <div id="container2" style="height: 250px; margin: 0 auto"></div>
                </div>
            
  </div></div></div>
</div>

        {* hostpro end *}  
{elseif $pid == "1153" || $pid == "1140" || $pid == "1151" || $pid=="1152"} 
{elseif  $pid != "1124"}
<div class="row">
    <div class="col-md-6">

        <div class="panel panel-default" id="cPanelPackagePanel">
            <div class="panel-heading">
                <h3 class="panel-title">{$LANG.cPanel.packageDomain}</h3>
            </div>
            <div class="panel-body text-center">

                <div class="cpanel-package-details">
                    <em>{$groupname}</em>
                    <h4 style="margin:0;">{$product}</h4>
                    <a href="http://{$domain}" target="_blank">www.{$domain}</a>
                </div>

                <p>
                    <a href="http://{$domain}" class="btn btn-default btn-sm" target="_blank">{$LANG.visitwebsite}</a>
                    {if $domainId}
                        <a href="clientarea.php?action=domaindetails&id={$domainId}" class="btn btn-success btn-sm" target="_blank">{$LANG.managedomain}</a>
                    {/if}
                    <input type="button" onclick="popupWindow('whois.php?domain={$domain}','whois',650,420);return false;" value="{$LANG.whoisinfo}" class="btn btn-info btn-sm" />
                </p>

            </div>
        </div>

        {if $availableAddonProducts}
            <div class="panel panel-default" id="cPanelExtrasPurchasePanel">
                <div class="panel-heading">
                    <h3 class="panel-title">{$LANG.cPanel.addonsExtras}</h3>
                </div>
                <div class="panel-body text-center">

                    <form method="post" action="cart.php?a=add" class="form-inline">
                        <input type="hidden" name="serviceid" value="{$serviceid}" />
                        <select name="aid" class="form-control input-sm">
                        {foreach $availableAddonProducts as $addonId => $addonName}
                            <option value="{$addonId}">{$addonName}</option>
                        {/foreach}
                        </select>
                        <button type="submit" class="btn btn-default btn-sm">
                            <i class="fa fa-shopping-cart"></i>
                            {$LANG.cPanel.purchaseActivate}
                        </button>
                    </form>

                </div>
            </div>
        {/if}

    </div>
    <div class="col-md-6">

        <div class="panel panel-default" id="cPanelUsagePanel">
            <div class="panel-heading">
                <h3 class="panel-title">{$LANG.cPanel.usageStats}</h3>
            </div>
            <div class="panel-body text-center cpanel-usage-stats">

                <div class="row">
                    <div class="col-sm-5 col-sm-offset-1 col-xs-6" id="diskUsage">
                        <strong>{$LANG.cPanel.diskUsage}</strong>
                        <br /><br />
                        <input type="text" value="{$diskpercent|substr:0:-1}" class="usage-dial" data-fgColor="#5dd0ed" data-bgColor="#999" data-angleOffset="-125" data-angleArc="250" data-min="0" data-max="100" data-readOnly="true" data-width="100" data-height="80" />
                        <br /><br />
                        {$diskusage} M / {$disklimit} M
                    </div>
                    <div class="col-sm-5 col-xs-6" id="bandwidthUsage">
                        <strong>{$LANG.cPanel.bandwidthUsage}</strong>
                        <br /><br />
                        <input type="text" value="{$bwpercent|substr:0:-1}" class="usage-dial" data-fgColor="#5dd0ed" data-bgColor="#999" data-angleOffset="-125" data-angleArc="250" data-min="0" data-max="100" data-readOnly="true" data-width="100" data-height="80" />
                        <br /><br />
                        {$bwusage} M / {$bwlimit} M
                    </div>
                </div>

                {if $bwpercent|substr:0:-1 > 75}
                    <div class="text-danger limit-near">
                        {$LANG.cPanel.usageStatsBwLimitNear}
                        {if $packagesupgrade}
                            <a href="upgrade.php?type=package&id={$serviceid}" class="btn btn-xs btn-danger">
                                <i class="fa fa-arrow-circle-up"></i>
                                {$LANG.cPanel.usageUpgradeNow}
                            </a>
                        {/if}
                    </div>
                {elseif $diskpercent|substr:0:-1 > 75}
                    <div class="text-danger limit-near">
                        {$LANG.cPanel.usageStatsDiskLimitNear}
                        {if $packagesupgrade}
                            <a href="upgrade.php?type=package&id={$serviceid}" class="btn btn-xs btn-danger">
                                <i class="fa fa-arrow-circle-up"></i>
                                {$LANG.cPanel.usageUpgradeNow}
                            </a>
                        {/if}
                    </div>
                {else}
                    <div class="text-info limit-near">
                        {$LANG.cPanel.usageLastUpdated} {$lastupdate}
                    </div>
                {/if}

                <script src="{$BASE_PATH_JS}/jquery.knob.js"></script>
                <script type="text/javascript">
                jQuery(function() {
                    jQuery(".usage-dial").knob({
                        'format': function (value) {
                            return value + '%';
                        }
                    });
                });
                </script>

            </div>
        </div>

    </div>
</div>

{/if}
{foreach $hookOutput as $output}
    <div>
        {$output}
    </div>
{/foreach}
{*hostpro start disable icons on wordpress packages*}{*hostpro end*}
{if $systemStatus == 'Active' && $pid == "1153" || $systemStatus == 'Active' && $pid == "1140" || $systemStatus == 'Active' && $pid == "1151" || $systemStatus == 'Active' && $pid == "1152"}

{elseif $systemStatus == 'Active' && $pid != "1124"}
    <div class="panel panel-default" id="cPanelQuickShortcutsPanel">
        <div class="panel-heading">
            <h3 class="panel-title">{$LANG.cPanel.quickShortcuts}</h3>
        </div>
        <div class="panel-body text-center">

            <div class="row cpanel-feature-row">
                <div class="col-sm-3 col-xs-6" id="cPanelEmailAccounts">
                    <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Email_Accounts" target="_blank">
                        <img src="modules/servers/cpanel/img/email_accounts.png" />
                        {$LANG.cPanel.emailAccounts}
                    </a>
                </div>
                <div class="col-sm-3 col-xs-6" id="cPanelForwarders">
                    <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Email_Forwarders" target="_blank">
                        <img src="modules/servers/cpanel/img/forwarders.png" />
                        {$LANG.cPanel.forwarders}
                    </a>
                </div>
                <div class="col-sm-3 col-xs-6" id="cPanelAutoResponders">
                    <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Email_AutoResponders" target="_blank">
                        <img src="modules/servers/cpanel/img/autoresponders.png" />
                        {$LANG.cPanel.autoresponders}
                    </a>
                </div>
                <div class="col-sm-3 col-xs-6" id="cPanelFileManager">
                    <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=FileManager_Home" target="_blank">
                        <img src="modules/servers/cpanel/img/file_manager.png" />
                        {$LANG.cPanel.fileManager}
                    </a>
                </div>
            </div>
            <div class="row cpanel-feature-row">
                <div class="col-sm-3 col-xs-6" id="cPanelBackup">
                    <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Backups_Home" target="_blank">
                        <img src="modules/servers/cpanel/img/backup.png" />
                        {$LANG.cPanel.backup}
                    </a>
                </div>
                <div class="col-sm-3 col-xs-6" id="cPanelSubdomains">
                    <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Domains_SubDomains" target="_blank">
                        <img src="modules/servers/cpanel/img/subdomains.png" />
                        {$LANG.cPanel.subdomains}
                    </a>
                </div>
                <div class="col-sm-3 col-xs-6" id="cPanelAddonDomains">
                    <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Domains_AddonDomains" target="_blank">
                        <img src="modules/servers/cpanel/img/addon_domains.png" />
                        {$LANG.cPanel.addonDomains}
                    </a>
                </div>
                <div class="col-sm-3 col-xs-6" id="cPanelCronJobs">
                    <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Cron_Home" target="_blank">
                        <img src="modules/servers/cpanel/img/cron_jobs.png" />
                        {$LANG.cPanel.cronJobs}
                    </a>
                </div>
            </div>
            <div class="row cpanel-feature-row">
                <div class="col-sm-3 col-xs-6" id="cPanelMySQLDatabases">
                    <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Database_MySQL" target="_blank">
                        <img src="modules/servers/cpanel/img/mysql_databases.png" />
                        {$LANG.cPanel.mysqlDatabases}
                    </a>
                </div>
                <div class="col-sm-3 col-xs-6" id="cPanelPhpMyAdmin">
                    <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Database_phpMyAdmin" target="_blank">
                        <img src="modules/servers/cpanel/img/php_my_admin.png" />
                        {$LANG.cPanel.phpMyAdmin}
                    </a>
                </div>
                <div class="col-sm-3 col-xs-6" id="cPanelAwstats">
                    <a href="clientarea.php?action=productdetails&amp;id={$serviceid}&amp;dosinglesignon=1&amp;app=Stats_AWStats" target="_blank">
                        <img src="modules/servers/cpanel/img/awstats.png" />
                        {$LANG.cPanel.awstats}
                    </a>
                </div>
            </div>

        </div>
    </div>

    <div class="panel panel-default" id="cPanelQuickEmailPanel">
        <div class="panel-heading">
            <h3 class="panel-title">{$LANG.cPanel.createEmailAccount}</h3>
        </div>
        <div class="panel-body">

            {include file="$template/includes/alert.tpl" type="success" msg=$LANG.cPanel.emailAccountCreateSuccess textcenter=true hide=true idname="emailCreateSuccess" additionalClasses="email-create-feedback"}

            {include file="$template/includes/alert.tpl" type="danger" msg=$LANG.cPanel.emailAccountCreateFailed|cat:' <span id="emailCreateFailedErrorMsg"></span>' textcenter=true hide=true idname="emailCreateFailed" additionalClasses="email-create-feedback"}

            <form id="frmCreateEmailAccount" onsubmit="doEmailCreate();return false">
                <input type="hidden" name="id" value="{$serviceid}" />
                <input type="hidden" name="email_quota" value="250" />
                <div class="row">
                    <div class="col-sm-6">
                        <div class="input-group">
                            <input type="text" name="email_prefix" class="form-control" placeholder="{$LANG.cPanel.usernamePlaceholder}">
                            <span class="input-group-addon">@{$domain}</span>
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <input type="password" name="email_pw" class="form-control" placeholder="{$LANG.cPanel.passwordPlaceholder}">
                    </div>
                    <div class="col-sm-3">
                        <button type="submit" class="btn btn-primary btn-block" />
                            <i class="fa fa-plus" id="btnCreateLoader"></i>
                            {$LANG.cPanel.create}
                        </button>
                    </div>
                </div>
            </form>

        </div>
    </div>

{elseif $pid != "1124"}

    <div class="alert alert-warning text-center" role="alert" id="cPanelSuspendReasonPanel">
        {if $suspendreason}
            <strong>{$suspendreason}</strong><br />
        {/if}
        {$LANG.cPanel.packageNotActive} {$status}.<br />
        {if $systemStatus eq "Pending"}
            {$LANG.cPanel.statusPendingNotice}
        {elseif $systemStatus eq "Suspended"}
            {$LANG.cPanel.statusSuspendedNotice}
        {/if}
    </div>

{/if}
{if $pid != "1124"}
{*hostpro start*}
{if $product == 'GuruHosting' || $product == 'GuruHosting-Trial' || $product == 'Guru-Dev' || $groupname eq "Wordpress Хостинг" || $groupname eq "Wordpress Hosting" }
{else} 

<div class="panel panel-default" id="cPanelBillingOverviewPanel">
    <div class="panel-heading">
        <h3 class="panel-title">{$LANG.cPanel.billingOverview}</h3>
    </div>
    <div class="panel-body">
        <div class="row">
            <div class="col-md-5">
                {if $firstpaymentamount neq $recurringamount}
                    <div class="row" id="firstPaymentAmount">
                        <div class="col-xs-6 text-right" >
                            {$LANG.firstpaymentamount}
                        </div>
                        <div class="col-xs-6">
                            {$firstpaymentamount}
                        </div>
                    </div>
                {/if}
                {if $billingcycle != $LANG.orderpaymenttermonetime && $billingcycle != $LANG.orderfree}
                    <div class="row" id="recurringAmount">
                        <div class="col-xs-6 text-right">
                            {$LANG.recurringamount}
                        </div>
                        <div class="col-xs-6">
                            {$recurringamount}
                        </div>
                    </div>
                {/if}
                <div class="row" id="billingCycle">
                    <div class="col-xs-6 text-right">
                        {$LANG.orderbillingcycle}
                    </div>
                    <div class="col-xs-6">
                        {$billingcycle}
                    </div>
                </div>
                <div class="row" id="paymentMethod">
                    <div class="col-xs-6 text-right">
                        {$LANG.orderpaymentmethod}
                    </div>
                    <div class="col-xs-6">
                        {$paymentmethod}
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="row" id="registrationDate">
                    <div class="col-xs-6 col-md-5 text-right">
                        {$LANG.clientareahostingregdate}
                    </div>
                    <div class="col-xs-6 col-md-7">
                        {$regdate}
                    </div>
                </div>
                <div class="row" id="nextDueDate">
                    <div class="col-xs-6 col-md-5 text-right">
                        {$LANG.clientareahostingnextduedate}
                    </div>
                    <div class="col-xs-6 col-md-7">
                        {$nextduedate}
                    </div>
                </div>
            </div>
        </div>
 </div>
</div>
{/if}
{/if}
