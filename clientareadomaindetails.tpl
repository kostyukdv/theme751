{* IMPORTANT! FILE WITH CUSTOM CHANGES *}
{include file="$template/pageheader.tpl" title=$LANG.managing|cat:' '|cat:$domain}
{if $updatesuccess}
<div class="alert alert-success">
    <p><!--{$LANG.changessavedsuccessfully} --> <i class="icon-time"></i> <strong>Ваша заявка принята, пожалуйста, ожидайте (от 3 до 72 часов).</strong></p>
</div>

{elseif $registrarcustombuttonresult=="success"}
{include file="$template/includes/alert.tpl" type="success" msg=$LANG.moduleactionsuccess textcenter=true}
{elseif $registrarcustombuttonresult}
{include file="$template/includes/alert.tpl" type="error" msg=$LANG.moduleactionfailed textcenter=true}
{/if}
<ul class="nav nav-material nav-material-horizontal px-lg-30 pt-lg-30">
    <li class="active"><a href="#tabOverview" data-toggle="tab">{$LANG.information}</a></li>
    <li><a href="#tabAutorenew" data-toggle="tab">{$LANG.domainsautorenew}</a></li>
    {if $rawstatus == "active" && $managens}<li><a href="#tabNameservers" data-toggle="tab">{$LANG.domainnameservers}</a></li>{/if}
    {*if $lockstatus}{if $tld neq "co.uk" && $tld neq "org.uk" && $tld neq "ltd.uk" && $tld neq "plc.uk" && $tld neq "me.uk"}<li><a href="#tabReglock" data-toggle="tab">{$LANG.domainregistrarlock}</a></li>{/if}{/if*}
    {if $releasedomain}<li><a href="#tabRelease" data-toggle="tab">{$LANG.domainrelease}</a></li>{/if}
    {*if $addonscount}<li><a href="#tabAddons" data-toggle="tab">{$LANG.clientareahostingaddons}</a></li>{/if*}
    {if $managecontacts || $registerns || $dnsmanagement || $emailforwarding || $getepp || $correctns}<li class="dropdown"><a data-toggle="dropdown" href="#" class="dropdown-toggle">{$LANG.domainmanagementtools}&nbsp;<b class="caret"></b></a>
    <ul class="dropdown-menu">
        {if $managecontacts}<li><a href="clientarea.php?action=domaincontacts&domainid={$domainid}">{$LANG.domaincontactinfo}</a></li>{/if}
        {if $registerns}<li><a href="clientarea.php?action=domainregisterns&domainid={$domainid}">{$LANG.domainregisterns}</a></li>{/if}
        {* uniweb start *}
        {if $correctns}<li><a href="domaindns.php?domainid={$domainid}">{$LANG.clientareadomainmanagedns}</a></li>{/if}
        {if $dnsmanagement && !$correctns}<li><a href="clientarea.php?action=domaindns&domainid={$domainid}">{$LANG.clientareadomainmanagedns}</a></li>{/if}
        {*if $dnsmanagement}<li><a href="clientarea.php?action=domaindns&domainid={$domainid}">{$LANG.clientareadomainmanagedns}</a></li>{/if*}
        {* uniweb end *}
        {if $emailforwarding}<li><a href="clientarea.php?action=domainemailforwarding&domainid={$domainid}">{$LANG.clientareadomainmanageemailfwds}</a></li>{/if}
        {*if $getepp}<li class="divider"></li>
        <li><a href="clientarea.php?action=domaingetepp&domainid={$domainid}">{$LANG.domaingeteppcode}</a></li>{/if*}
        {if $registrarcustombuttons}<li class="divider"></li>
        {foreach from=$registrarcustombuttons key=label item=command}
        <li><a href="clientarea.php?action=domaindetails&amp;id={$domainid}&amp;modop=custom&amp;a={$command}">{$label}</a></li>
        {/foreach}{/if}
    </ul>
</li>{/if}
{* uniweb start *}
{if $rawstatus == "active"}<li><a href="#tabRemove" data-toggle="tab">{$LANG.domainremove}</a></li>{/if}
{* uniweb end *}
</ul>
<div class="tab-content">
    <div class="tab-pane fade in active" id="tabOverview">
        {if $systemStatus != 'Active'}
        <div class="alert alert-warning text-center" role="alert">
            {$LANG.domainCannotBeManagedUnlessActive}
        </div>
        {/if}
        {include file="$template/subheader.tpl" title=$LANG.overview}
        {if $lockstatus eq "unlocked"}
        {capture name="domainUnlockedMsg"}<strong>{$LANG.domaincurrentlyunlocked}</strong><br />{$LANG.domaincurrentlyunlockedexp}{/capture}
        {include file="$template/includes/alert.tpl" type="error" msg=$smarty.capture.domainUnlockedMsg}
        {/if}
        <div class="well mx-1">
        <div class="row">
            <div class="col-sm-6">
                <dl class="dl-horizontal">
                  <dt>{$LANG.clientareahostingdomain}</dt>
                  <dd><a href="http://{$domain}" target="_blank">{$domain}</a></dd>
                  <dt>{$LANG.clientareahostingregdate}</dt>
                  <dd>{$registrationdate}</dd>
                  <dt>{$LANG.clientareahostingnextduedate}</dt>
                  <dd>{$nextduedate}</dd>
                  <dt>{$LANG.clientareastatus}</dt>
                  <dd>{$status}</dd>
              </dl>
          </div>
          <div class="col-sm-6">
            <dl class="dl-horizontal">
              <dt>{$LANG.firstpaymentamount}</dt>
              <dd>{$firstpaymentamount}</dd>
              <dt>{$LANG.recurringamount}</dt>
              <dd>{$recurringamount} {$LANG.every} {$registrationperiod} {$LANG.orderyears}{* uniweb start *}{if $renew} &nbsp; <a href="cart.php?gid=renewals&renewalid={$domainid}" class="btn btn-xs btn-success">{$LANG.domainsrenewnow}</a>{/if}{* uniweb end *}</dd>
              <dt>{$LANG.orderpaymentmethod}</dt>
              <dd>{$paymentmethod}</dd>
          </dl>
      </div>
  </div>
</div>
  {*if $registrarclientarea}
  <div class="moduleoutput">
    {$registrarclientarea|replace:'modulebutton':'btn'}
</div>
{/if*}
{foreach $hookOutput as $output}
<div>
    {$output}
</div>
{/foreach}
        {if $systemStatus == 'Active'
            and (
                $managementoptions.nameservers or
                $managementoptions.contacts or
                $managementoptions.locking or
                $renew)}
                {* No reason to show this section if nothing can be done here! *}
{include file="$template/subheader.tpl" title=$LANG.doToday}
<div class="well mx-1">
  <ul class="list-unstyled">
                {if $managementoptions.nameservers}
                    <li>
                        <a class="tabControlLink" data-toggle="tab" href="#tabNameservers">
                            {$LANG.changeDomainNS}
                        </a>
                    </li>
                {/if}
                {if $managementoptions.contacts}
                    <li>
                        <a href="clientarea.php?action=domaincontacts&domainid={$domainid}">
                            {$LANG.updateWhoisContact}
                        </a>
                    </li>
                {/if}
                {*if $managementoptions.locking}
                    <li>
                        <a class="tabControlLink" data-toggle="tab" href="#tabReglock">
                            {$LANG.changeRegLock}
                        </a>
                    </li>
                {/if*}
                {if $renew}
                    <li>
                        <a href="cart.php?gid=renewals">
                            {$LANG.renewYourDomain}
                        </a>
                    </li>
                {/if}
            </ul>
</div>
        {/if}
</div>
<div class="tab-pane fade" id="tabAutorenew">
{include file="$template/subheader.tpl" title=$LANG.domainsautorenew}

    {if $changeAutoRenewStatusSuccessful}
    {include file="$template/includes/alert.tpl" type="success" msg=$LANG.changessavedsuccessfully textcenter=true}
    {/if}
    {include file="$template/includes/alert.tpl" type="info" msg=$LANG.domainrenewexp}
    <div class="row">
    <div class="col-md-6 col-md-offset-3">
      <div class="well">
  <h4 class="py-1">{$LANG.domainautorenewstatus} <span class="pull-right flip"><span class="label label-{if $autorenew}success{else}danger{/if}">{if $autorenew}{$LANG.domainsautorenewenabled}{else}{$LANG.domainsautorenewdisabled}{/if}</span></span></h4>
    <form method="post" action="{$smarty.server.PHP_SELF}?action=domaindetails#tabAutorenew">
        <input type="hidden" name="id" value="{$domainid}">
        <input type="hidden" name="sub" value="autorenew" />
        {if $autorenew}
        <input type="hidden" name="autorenew" value="disable">
        <div class="form-group">
            <input type="submit" class="btn btn-lg btn-danger btn-block" value="{$LANG.domainsautorenewdisable}" />
        </div>
        {else}
        <input type="hidden" name="autorenew" value="enable">
        <div class="form-group">
            <input type="submit" class="btn btn-lg btn-success btn-block" value="{$LANG.domainsautorenewenable}" />
        </div>
        {/if}
    </form>
</div>
</div>
</div>
</div>
<div class="tab-pane fade" id="tabNameservers">
    <h3>Nameservers</h3>
    {if $nameservererror}
    {include file="$template/includes/alert.tpl" type="error" msg=$nameservererror textcenter=true}
    {/if}
    {if $subaction eq "savens"}
    {if $updatesuccess}
    {include file="$template/includes/alert.tpl" type="success" msg=$LANG.changessavedsuccessfully textcenter=true}
    {elseif $error}
    {include file="$template/includes/alert.tpl" type="error" msg=$error textcenter=true}
    {/if}
    {/if}
    {include file="$template/includes/alert.tpl" type="info" msg=$LANG.domainnsexp}
    <form class="form-horizontal p-2" role="form" method="post" action="{$smarty.server.PHP_SELF}?action=domaindetails#tabNameservers">
        <input type="hidden" name="id" value="{$domainid}" />
        <input type="hidden" name="sub" value="savens" />
        <div class="radio">
            <label>
                <input type="radio" name="nschoice" value="default" onclick="disableFields('domnsinputs',true)"{if $defaultns} checked{/if} /> {$LANG.nschoicedefault}
            </label>
        </div>
        <div class="radio">
            <label>
                <input type="radio" name="nschoice" value="custom" onclick="disableFields('domnsinputs',false)"{if !$defaultns} checked{/if} /> {$LANG.nschoicecustom}
            </label>
        </div>
        <br />
        {for $num=1 to 5}
        <div class="form-group">
            <label for="inputNs{$num}" class="col-sm-4 control-label">{$LANG.clientareanameserver} {$num}</label>
            <div class="col-sm-7">
                <input type="text" name="ns{$num}" class="form-control domnsinputs" id="inputNs{$num}" value="{$nameservers[$num].value}" />
            </div>
        </div>
        {/for}
        <p class="text-center">
            <input type="submit" class="btn btn-primary" value="{$LANG.changenameservers}" />
        </p>
    </form>
</div>
<div class="tab-pane fade" id="tabReglock">
    <h3>{$LANG.domainregistrarlock}</h3>
    {if $subaction eq "savereglock"}
    {if $updatesuccess}
    {include file="$template/includes/alert.tpl" type="success" msg=$LANG.changessavedsuccessfully textcenter=true}
    {elseif $error}
    {include file="$template/includes/alert.tpl" type="error" msg=$error textcenter=true}
    {/if}
    {/if}
    {include file="$template/includes/alert.tpl" type="info" msg=$LANG.domainlockingexp}
    <div class="row">
    <div class="col-md-6">{$LANG.domainreglockstatus}: <span class="label label-{if $lockstatus == "locked"}success{else}danger{/if}">{if $lockstatus == "locked"}{$LANG.domainsautorenewenabled}{else}{$LANG.domainsautorenewdisabled}{/if}</span></div>
    <form method="post" action="{$smarty.server.PHP_SELF}?action=domaindetails#tabReglock">
        <input type="hidden" name="id" value="{$domainid}">
        <input type="hidden" name="sub" value="savereglock" />
        {if $lockstatus=="locked"}
        <div class="col-md-6 text-right">
            <input type="submit" class="btn btn-xs btn-danger" value="{$LANG.domainreglockdisable}" />
        </div>
        {else}
        <input type="hidden" name="autorenew" value="enable">
        <div class="col-md-6 text-right">
            <input type="submit" class="btn btn-xs btn-success" name="reglock" value="{$LANG.domainreglockenable}" />
        </div>
        {/if}
    </form>
</div>
</div>
<div class="tab-pane fade" id="tabRelease">
    <h3>{$LANG.domainrelease}</h3>
    {include file="$template/includes/alert.tpl" type="info" msg=$LANG.domainreleasedescription}
    <form class="form-horizontal p-2" role="form" method="post" action="{$smarty.server.PHP_SELF}?action=domaindetails">
        <input type="hidden" name="sub" value="releasedomain">
        <input type="hidden" name="id" value="{$domainid}">
        <div class="form-group">
            <label for="inputReleaseTag" class="col-xs-4 control-label">{$LANG.domainreleasetag}</label>
            <div class="col-xs-6 col-sm-5">
                <input type="text" class="form-control" id="inputReleaseTag" name="transtag" />
            </div>
        </div>
        <p class="text-center">
            <input type="submit" value="{$LANG.domainrelease}" class="btn btn-primary" />
        </p>
    </form>
</div>
<div class="tab-pane fade" id="tabAddons">
    <h3>{$LANG.domainaddons}</h3>
    <p>
        {$LANG.domainaddonsinfo}
    </p>
        {if $addons.idprotection}
            <div class="row margin-bottom">
            <div class="col-md-12">
            <div class="well">
            <h3>
            <span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-shield fa-stack-1x fa-inverse"></i></span>
            {$LANG.domainidprotection}
            </h3>
                <p>{$LANG.domainaddonsidprotectioninfo}</p>
                <form action="clientarea.php?action=domainaddons" method="post">
                    <input type="hidden" name="id" value="{$domainid}"/>
                    {if $addonstatus.idprotection}
                        <input type="hidden" name="disable" value="idprotect"/>
                        <input type="submit" value="{$LANG.disable}" class="btn btn-link"/>
                    {else}
                        <input type="hidden" name="buy" value="idprotect"/>
                        <input type="submit" value="{$LANG.domainaddonsbuynow} {$addonspricing.idprotection}" class="btn btn-link"/>
                    {/if}
                </form>
            </div>
            </div>
        </div>
        {/if}
        {if $addons.dnsmanagement}
            <div class="row margin-bottom">
            <div class="col-md-12">
            <div class="well">
                <h3><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-cloud fa-stack-1x fa-inverse"></i></span>
                {$LANG.domainaddonsdnsmanagement}
                </h3>
                <p>{$LANG.domainaddonsdnsmanagementinfo}</p>
                <form action="clientarea.php?action=domainaddons" method="post">
                    <input type="hidden" name="id" value="{$domainid}"/>
                    {if $addonstatus.dnsmanagement}
                        <input type="hidden" name="disable" value="dnsmanagement"/>
                        <a class="btn btn-link" href="clientarea.php?action=domaindns&domainid={$domainid}">{$LANG.manage}</a> | <input type="submit" value="{$LANG.disable}" class="btn btn-link"/>
                    {else}
                        <input type="hidden" name="buy" value="dnsmanagement"/>
                        <input type="submit" value="{$LANG.domainaddonsbuynow} {$addonspricing.dnsmanagement}" class="btn btn-link"/>
                    {/if}
                </form>
            </div>
            </div>
        </div>
        {/if}
        {if $addons.emailforwarding}
        <div class="row margin-bottom">
            <div class="col-md-12">
            <div class="well">
                <h3><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-mail-forward fa-stack-1x fa-inverse"></i></span>
                {$LANG.domainemailforwarding}
                </h3>
                <p>{$LANG.domainaddonsemailforwardinginfo}</p>
                <form action="clientarea.php?action=domainaddons" method="post">
                    <input type="hidden" name="id" value="{$domainid}"/>
                    {if $addonstatus.emailforwarding}
                        <input type="hidden" name="disable" value="emailfwd"/>
                        <a class="btn btn-link" href="clientarea.php?action=domainemailforwarding&domainid={$domainid}">{$LANG.manage}</a> | <input type="submit" value="{$LANG.disable}" class="btn btn-link"/>
                    {else}
                        <input type="hidden" name="buy" value="emailfwd"/>
                        <input type="submit" value="{$LANG.domainaddonsbuynow} {$addonspricing.emailforwarding}" class="btn btn-link"/>
                    {/if}
                </form>
            </div>
        	</div>
        </div>
        {/if}
</div>
{* uniweb start *}
<div class="tab-pane fade" id="tabRemove">
    <div class="internalpadding">
        <div class="styled_title"><h3>{$LANG.domainremove}</h3></div>
        <div class="alert alert-info">
            <strong>Внимание!</strong> Возврат оплаты за оставшейся период не предусмотрен!
        </div>
        
        <p>{$LANG.domainremovedescription}</p>
    
        {if !empty($errors)}
            {foreach from=$errors item=error}
                <div class="alert alert-block alert-error">
                    {$error}
                </div>
            {/foreach}
        {/if}
        {if isset($smarty.post.submit) && empty($errors)}
           <div class="alert alert-block alert-success">
               {$LANG.domainremovesuccess}
            </div>
        {else}
            <form method="post" action="{$smarty.server.PHP_SELF}?action=domaindetails&id={$domainid}#tabRemove">
                <input type="hidden" name="sub" value="remove">
                <div class="form-group">
                    <textarea class="form-control" id="cause" name="cause" rows="4" ></textarea>
                </div>
                <div class="form-group">
                    <input type="submit" class="btn btn-large btn-danger" name="submit" value="{$LANG.domainremove}">
                </div>
            </form>
        {/if}
    </div>
</div>
{* uniweb end *}
</div>
