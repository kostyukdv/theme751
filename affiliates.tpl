{* IMPORTANT! FILE WITH CUSTOM CHANGES *}
{if $inactive}
{include file="$template/pageheader.tpl" title=$LANG.affiliatestitle icon=diamond}
<div class="alert alert-warning">
  <p>{$LANG.affiliatesdisabled}</p>
</div>
{else}
{* uniweb start *}
{if (!empty($aff_checkout.msg))}
<div class="alert alert-success">
    <p>{$aff_checkout.msg}</p>
</div>
{/if}
{* uniweb end *}

{include file="$template/pageheader.tpl" title=$LANG.affiliatestitle desc=$LANG.affiliatesrealtime icon=diamond}

<div class="row">
	<div class="col-md-12">
		<h3 {*class="page-header"*}>
		{if $icon}<span aria-hidden="true" class="icon icon-{$icon}"></span>{/if} {$title} {if $desc}<i class="fa fa-angle-down show-info" aria-hidden="true"></i>{/if}
		{* uniweb start *}<a class='delete-aff-program btn btn-danger pull-right' onclick='return confirm("Вы действительно хотите отключить партнерскую программу")' href='/affiliates.php?action=delete_affiliate_program'>Отключить партнёрку</a>{* uniweb end *}</h3>
		{if $desc}
		<blockquote class="page-information hidden">
			<p>{$desc}</p>
		</blockquote>
		{/if}
	</div>
</div>
<div class="row px-1 py-2">
  <div class="col-md-12">
    <div class="form-group st-input">
      <label for="code" class="col-sm-12 col-md-3 control-label"><h4 class="hp-gray-dark">{$LANG.affiliatesreferallink}</h4></label>
      <div class="col-md-9 col-sm-12">
         <input type="text" value="{$referrallink}" class="form-control" />
      </div>
    </div>
  </div>
</div>
<div class="row px-1">
{*hostpro start*}
  <div class="col-md-4 col-sm-12">
    <div class="card">
     <div class="card-body">
      <h3 class="text-center hp-gray">{$visitors}</h3>
      <h5 class="card-title text-center">{$LANG.affiliatesvisitorsreferred}</h5>
     </div>
    </div>
  </div>
  <div class="col-md-4 col-sm-12">
    <div class="card">
     <div class="card-body">
      <h3 class="text-center hp-success">{$signups}</h3>
      <h5 class="card-title text-center">{$LANG.affiliatessignups}</h5>
     </div>
    </div>
  </div>

  <div class="col-md-4 col-sm-12">
    <div class="card">
     <div class="card-body">
      <h3 class="text-center hp-cyan">{$conversionrate}%</h3>
      <h5 class="card-title text-center">{$LANG.affiliatesconversionrate}</h5>
     </div>
    </div>
  </div>
</div>
{* uniweb start *}
<div class="row py-1">
   <div class="col-md-12 col-sm-12">
	  <h4>Партнёрский баланс</h4>
          <hr style="margin-top:0px;">
   </div>
</div>
{* uniweb end *}

<div class="row px-1">
  <div class="col-md-4 col-sm-12">
    <div class="card">
     <div class="card-body">
      <h3 class="text-center hp-gray">{$pendingcommissions|replace:"USD":""}</h3>
      <h5 class="card-title text-center">{$LANG.affiliatescommissionspending}</h5>
     </div>
    </div>
  </div>

  <div class="col-md-4 col-sm-12">
    <div class="card">
     <div class="card-body">
      <h3 class="text-center hp-success">{$balance|replace:"USD":""}</h3>
      <h5 class="card-title text-center">{$LANG.affiliatescommissionsavailable}</h5>
     </div>
    </div>
  </div>

  <div class="col-md-4 col-sm-12">
    <div class="card">
     <div class="card-body">
      <h3 class="text-center hp-cyan">{$withdrawn|replace:"USD":""}</h3>
      <h5 class="card-title text-center">{$LANG.affiliateswithdrawn}</h5>
     </div>
    </div>
  </div>
</div>

{* uniweb start *}

{* start affcoupons *}
<div id="affcoupons-ajax" class="row py-2">
  <div class="col-md-12">
    <h4>Целевая страница</h4>
    <hr style="margin-top:0px;">
    <div class="affnotice">
        <div id="notice" class="alert alert-{if !$notice_type}success{else}{$notice_type}{/if}" {if !$notice}style="display: none;"{/if}>{$notice}</div>
    </div>
    <form method="POST" action="{$index_page}?m=affcoupons" name="landingpage" id="landingpageForm">
        <input type="hidden" name="cmd" value="modlanding">
        <div class="col-md-2 hidden-xs"></div>
        <div class="{*well*} textcenter st-input col-md-8 col-sm-12">
            <input type="text" name="landing" id="landing" value="{$landing}" class="form-control">
            <div class="internalpaadding">
                <p class="text-muted">Эта опция позволяет перенаправлять клиентов после посещения вашей реферальной ссылки.</p>
                <input type="submit" name="Submit" value="Изменить" class="btn btn-primary btn-large" id="updatelanding">
            </div>
        </div>
    </form>
  </div>
</div>
<div class="row">
  <div class="col-md-12 col-sm-12">
 		<h4>Ваши купоны</h4>
		<hr style="margin-top:0px;">
	
                <table align="center" class="table table-striped table-framed table-centered">
		    <thead>
		        <tr>
		            <th>&nbsp;</th>
		            <th>Код скидки</th>
		            <th>Тип купона</th>
		            <th>Значение купона</th>
		            <th>Пользователи</th>
		        </tr>
		    </thead>
	
		    {if !$coupon}
				<tbody><tr><td colspan="5" style="text-align: center; font-weight: bold;">Купоны отсутствуют</td></tr></tbody>
		    {else}
			    <tbody>
					{foreach from=$coupon key=k item=v}
						<tr>
							<td>
								<a href="{$index_page}?m=affcoupons&cmd=del&cid={$v.id}" onclick='return confirm("Вы действительно хотите удалить этот купон?")'>
									<i class="fa fa-trash-o"></i>
								</a>
							</td>
							<td>{$v.code}</td>
							<td>{$v.type}</td>
							<td>{$v.value}</td>
							<td>{$v.uses}</td>
						</tr>
					{/foreach}
			    </tbody>
		    {/if}
	
		</table>
	</div>
 </div>
 <div class="row">
	<div class="col-md-12">
        <h4>Добавить код скидки</h4>
        <hr style="margin-top:0px;">
		
		<div style="padding: 10px 0 0 0">
			<form action="{$index_page}?m=affcoupons" method="POST" name="addcoupons" class="form-horizontal">
			    <input type="hidden" name="cmd" value="add">

		        <div class="form-group st-input">
				    <label for="code" class="control-label col-sm-12 col-md-2">Код скидки:</label>
				    <div class="col-md-5 col-sm-12">
				        <input type="text" name="code" id="code" class="form-control">
				    </div>
				</div>
		       <div class="form-group st-input">
				    <label for="code" class="col-sm-12 col-md-2 control-label">Тип скидки:</label>
				    <div class="col-sm-12 col-md-5">
				        {* hostpro start *}
                                        <select name="type" class="form-control">
							{foreach from=$avail_coupon item=v}
                                                         {if $v.label eq "Скидка 10% на Хостинг"}
                                                           {continue}
                                                         {/if}
								<option value="{$v.enc_string}">{$v.label}</option>
							{/foreach}
				        </select>
                                        {* hostpro end *}
				    </div>
				</div>
		        <div class="form-group col-md-7 col-sm-12">
					<p class="text-center">
						<input type="submit" name="Submit" value="Добавить" class="btn btn-primary btn-large">
					</p>
		        </div>
			</form>
		</div>
	</div>
</div>
{* end affcoupons *}

<a name="affiliates"></a>
<div class="row">
        <div class="col-md-12">
  {*hostpro start*}
  <h4>Вывод денег с партнерского баланса</h4>
  <hr style="margin-top:0px;">
  {*hostpro end*}
  {if !empty($aff_checkout.errors)}
  {foreach item=error from=$aff_checkout.errors}
  <div class="alert alert-error">
      <p>{$error}</p>
  </div>
  {/foreach}
  {/if}
  {if (!empty($aff_checkout.msgpayout))}
  <div class="alert alert-success">
      <p>{$aff_checkout.msgpayout}</p>
  </div>
  {/if}
  {* На Webmoney и банковский счет деньги переводятся в гривнах по текущему внутреннему курсу: <b>{$aff_checkout.curs}</b> *}
  <div style="padding: 10px 0 0 0">
      <form method="post" class="form-horizontal" action="{$smarty.server.PHP_SELF}#affiliates">
          <input type="hidden" name="action" value="payout"/>
          <div class="form-group st-input">
            <label for="checkout_sum" class="col-sm-12 col-md-2 control-label">Сумма перевода</label>
            <div class="col-md-5 col-sm-12">
              <input type="text" class="form-control" name="checkout_sum" id="checkout_sum" value="{$postData.checkout_sum}"> 
            </div>
          </div>
          <div class="form-group st-input">
            <label for="checkout_type" class="col-sm-12 col-md-2 control-label">Метод платежа</label>
            <div class="col-sm-12 col-md-5">
              <select id="checkout_type" class="form-control" name="checkout_type" onchange="javascript:displayFieldsBlock(this)">
                  <option label="Webmoney" value="wm">Webmoney</option>
                  <option label="Кредитная карточка" value="card">Кредитная карточка</option>
                  <option label="Основной баланс" value="hosting" selected="selected">Основной баланс</option>
              </select>
            </div>
          </div>
          
          <div id="checkout_fields" style="padding:10px 0 0 0; display:none">
              <div id="wm_fields" style="display:none">
                  <div class="form-group st-input">
                    <label for="wm_fio" class="col-sm-12 col-md-2 control-label">ФИО</label>
                    <div class="col-sm-12 col-md-5">
                      <input type="text" class="form-control" name="wm_fio" id="wm_fio" size="30" value="{$postData.wm_fio}" />
                    </div>
                  </div>
                  <div class="form-group st-input">
                    <label for="wm_purse" class="col-sm-12 col-md-2 control-label">Номер кошелька WMU</label>
                    <div class="col-sm-12 col-md-5 ">
                      <input type="text" class="form-control" name="wm_purse" id="wm_purse" size="30" value="{$postData.wm_purse}" />
                    </div>
                  </div>
              </div>
              <div id="card_fields" style="display:none">
                <div class="form-group st-input">
                  <label for="card_fio" class="col-sm-12 col-md-2 control-label">ФИО</label>
                  <div class="col-sm-12 col-md-5 ">
                    <input type="text" class="form-control" name="card_fio" id="card_fio" size="30" value="{$postData.card_fio}" />
                  </div>
                </div>
                <div class="form-group st-input">
                  <label for="card_number" class="col-sm-12 col-md-2 control-label">Номер гривневой карточки</label>
                  <div class="col-sm-12 col-md-5 ">
                    <input type="text" class="form-control" name="card_number" id="card_number" size="30" value="{$postData.card_number}" />
                  </div>
                </div>
                <div class="form-group st-input">
                  <label for="card_bank" class="col-sm-12 col-md-2 control-label">Банк, в котором открыта карточка</label>
                  <div class="col-sm-12 col-md-5">
                    <input type="text" class="form-control" name="card_bank" id="card_bank" size="30" value="{$postData.card_bank}" />
                  </div>
                </div>
              </div>
          </div>
          <div class="col-md-7 col-sm-12">
            <p class="text-center"><input type="submit" name="go_checkout" value="Перевести" class="btn btn-success" /></p>
          </div>
      </form>
    {*hostpro start*}
     <div class="col-md-7 col-sm-12">
      <p class="text-center text-muted"><small>{$LANG.affwithdraw}</small></p>
     </div>
    {*hostpro end*}
  </div>

  <script>
  displayFieldsBlock(document.getElementById('checkout_type'));

  function displayFieldsBlock(checkoutTypeObj) {
      var checkout_type = checkoutTypeObj.value;      
      document.getElementById('checkout_fields').style.display = 'none';
      document.getElementById('wm_fields').style.display = 'none';
      document.getElementById('card_fields').style.display = 'none';
      if (checkout_type == 'wm' || checkout_type == 'card') {
          document.getElementById('checkout_fields').style.display = 'block';
          document.getElementById(checkout_type+'_fields').style.display = 'block';
      }   
  }
  </script>
</div>
<div class="col-md-12">
 <h4>
  {if ($smarty.get.all_checkouts == 0)}
  Выведены деньги с партнерского баланса за текущий год <a href='/affiliates.php?all_checkouts=1#affiliates'>Показать все</a>
  {else}
  Выведены деньги с партнерского баланса <a href='/affiliates.php?all_checkouts=0#affiliates'>Показать за текущий год</a>
  {/if}
 </h4>
 <hr style="margin-top:0px;">
  <table align="center" class="table table-striped table-framed table-centered">
      <thead>
          <tr class="clientareatableheading"><th style="width: 100px">Дата</th><th>Сумма</th></tr>
      </thead>
      <tbody>
      {foreach key=num item=request from=$aff_checkout.requests}
      <tr class="clientareatableactive">
          <td class="center">{$request.date|date_format:"%d/%m/%Y"}</td>
          <td class="right">{$request.amount} {$CONFIG.CurrencySymbol}</td>
      </tr>
      {foreachelse}
      <tr class="clientareatableactive">
          <td colspan="6">Вы еще не делали запросов на вывод денег</td>
      </tr>
      {/foreach}
      </tbody>
  </table>
</div>
</div>

{* uniweb end *}
{* if $withdrawrequestsent}
<div class="alert alert-success">
  <p>{$LANG.affiliateswithdrawalrequestsuccessful}</p>
</div>
{else}
{if $withdrawlevel}
<input type="button" class="btn btn-default btn-sm" value="{$LANG.affiliatesrequestwithdrawal}" onclick="window.location='{$smarty.server.PHP_SELF}?action=withdrawrequest'" />
{/if}
{/if*}

{include file="$template/subheader.tpl" title=$LANG.affiliatesreferals}
{include file="$template/includes/tablelist.tpl" tableName="AffiliatesList"}
<script type="text/javascript">
jQuery(document).ready( function ()
{
  var table = jQuery('#tableAffiliatesList').removeClass('hidden').DataTable();
  {if $orderby == 'regdate'}
  table.order(0, '{$sort}');
  {elseif $orderby == 'product'}
  table.order(1, '{$sort}');
  {elseif $orderby == 'amount'}
  table.order(2, '{$sort}');
  {elseif $orderby == 'status'}
  table.order(4, '{$sort}');
  {/if}
  table.draw();
  jQuery('#tableLoading').addClass('hidden');
});
</script>
<div class="panel panel-default panel-datatable">
  <div class="panel-heading clearfix">
    <div class="filter_top panel panel-default panel-actions view-filter-btns" >
      <div class="elemetsholder ">
        <a class="btn btn-link btn-xs" href="#" ></a>
      </div>
    </div>
  </div>
  <table class="table table-striped table-framed" id="tableAffiliatesList">
    <thead>
      <tr>
        <th class="hidden-sm hidden-xs">{$LANG.affiliatessignupdate}</th>
        <th>{$LANG.orderproduct}</th>
        <th class="hidden-sm hidden-xs">{$LANG.affiliatesamount}</th>
        <th class="hidden-xs">{$LANG.affiliatescommission}</th>
        <th>{$LANG.affiliatesstatus}</th>
      </tr>
    </thead>
    {foreach from=$referrals item=referral}
    <tr>
      <td class="hidden-sm hidden-xs">{$referral.date}</td>
      <td>{$referral.service}

        <ul class="cell-inner-list visible-sm visible-xs small">
          <li><span class="item-title">{$LANG.affiliatessignupdate}: </span>{$referral.date}</li>
          <li><span class="item-title">{$LANG.affiliatesamount}: </span>{$referral.amountdesc}</li>
          <li class="hidden-sm"><span class="item-title">{$LANG.affiliatescommission}: </span>{$referral.commission}</li>
        </ul>

      </td>
      <td data-order="{$referral.amountnum}" class="hidden-sm hidden-xs">{$referral.amountdesc}</td>
      <td data-order="{$referral.commissionnum}" class="hidden-xs">{$referral.commission}</td>
      <td><span class='label status status-{$referral.rawstatus|strtolower}'>{$referral.status}</span></td>
    </tr>
    {/foreach}
  </table>
  <div class="text-center" id="tableLoading">
    <p><i class="fa fa-spinner fa-spin"></i> {$LANG.loading}</p>
  </div>
</div>
<ul class="pagination px-1">
  <li class="prev{if !$prevpage} disabled{/if}"><a href="{if $prevpage}affiliates.php?page={$prevpage}{else}javascript:return false;{/if}">&larr; {$LANG.previouspage}</a></li>
  <li class="next{if !$nextpage} disabled{/if}"><a href="{if $nextpage}affiliates.php?page={$nextpage}{else}javascript:return false;{/if}">{$LANG.nextpage} &rarr;</a></li>
</ul>
{if $affiliatelinkscode}
{include file="$template/subheader.tpl" title=$LANG.affiliateslinktous}
{*<div class="textcenter">*}
{* uniweb start *}
<div class="tabbable">
<ul class="nav nav-tabs">
  <!-- <li class="active"><a href="#tab1" data-toggle="tab"><span class="glyphicon glyphicon-gift"></span> Акционные баннеры</a></li> -->
  <li class="active"><a href="#tab2" data-toggle="tab"><span class="glyphicon glyphicon-heart"></span> Общие баннеры</a></li>
  <li><a href="#tab3" data-toggle="tab"><span class="glyphicon glyphicon-star"></span> Хостинг баннеры</a></li>
  <li><a href="#tab4" data-toggle="tab"><span class="glyphicon glyphicon-cloud"></span> ВПС баннеры</a></li> 
  <li><a href="#tab5" data-toggle="tab"><span class="glyphicon glyphicon-time"></span> Старые баннеры</a></li>
</ul>
<div class="tab-content">
<!-- ================================================================================================================================================================
--> 
 <div class="tab-pane active" id="tab2">
    <h3 style="text-align: left;">Общий баннер 120x600</h3>
     <div class="row-fluid">
       <div class="span8">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="Linux Хостинг от HostPro" src="https://billing.hostpro.ua/banners/general/Blue/120x600.png" title="Linux Хостинг от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span4">
       <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/general/Blue/120x600.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">Общий баннер 120x600</h3>
     <div class="row-fluid">
       <div class="span8">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="Linux Хостинг от HostPro" src="https://billing.hostpro.ua/banners/general/Orange/120x600.png" title="Linux Хостинг от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span4">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/general/Orange/120x600.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">Общий баннер 200x200</h3>     
     <div class="row-fluid">
       <div class="span8">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="Linux Хостинг от HostPro" src="https://billing.hostpro.ua/banners/general/Blue/200x200.png" title="Linux Хостинг от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span4">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/general/Blue/200x200.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">Общий баннер 200x200</h3>
     <div class="row-fluid">
       <div class="span8">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="Linux Хостинг от HostPro" src="https://billing.hostpro.ua/banners/general/Orange/200x200.png" title="Linux Хостинг от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span4">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/general/Orange/200x200.png">
       </div>
     </div> 
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">Общий баннер 250x250</h3>
     <div class="row-fluid">
       <div class="span8">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="Linux Хостинг от HostPro" src="https://billing.hostpro.ua/banners/general/Blue/250x250.png" title="Linux Хостинг от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span4">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/general/Blue/250x250.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">Общий баннер 250x250</h3>
     <div class="row-fluid">
       <div class="span8">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="Linux Хостинг от HostPro" src="https://billing.hostpro.ua/banners/general/Orange/250x250.png" title="Linux Хостинг от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span4">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/general/Orange/250x250.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">Общий баннер 300x250</h3>
     <div class="row-fluid">
       <div class="span8">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="Linux Хостинг от HostPro" src="https://billing.hostpro.ua/banners/general/Blue/300x250.png" title="Linux Хостинг от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span4">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/general/Blue/300x250.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
  <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">Общий баннер 300x250</h3>
     <div class="row-fluid">
       <div class="span8">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="Linux Хостинг от HostPro" src="https://billing.hostpro.ua/banners/general/Orange/300x250.png" title="Linux Хостинг от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span4">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/general/Orange/300x250.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">Общий баннер 300x600</h3>
     <div class="row-fluid">
       <div class="span8">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="Linux Хостинг от HostPro" src="https://billing.hostpro.ua/banners/general/Blue/300x600.png" title="Linux Хостинг от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span4">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/general/Blue/300x600.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">Общий баннер 300x600</h3>
     <div class="row-fluid">
       <div class="span8">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="Linux Хостинг от HostPro" src="https://billing.hostpro.ua/banners/general/Orange/300x600.png" title="Linux Хостинг от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span4">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/general/Orange/300x600.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">Общий баннер 336x280</h3>
     <div class="row-fluid">
       <div class="span7">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="Linux Хостинг от HostPro" src="https://billing.hostpro.ua/banners/general/Blue/336x280.png" title="Linux Хостинг от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span5">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/general/Blue/336x280.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">Общий баннер 336x280</h3>
     <div class="row-fluid">
       <div class="span7">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="Linux Хостинг от HostPro" src="https://billing.hostpro.ua/banners/general/Orange/336x280.png" title="Linux Хостинг от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span5">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/general/Orange/336x280.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">Общий баннер 468x60</h3>
     <div class="row-fluid">
       <div class="span12">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="Linux Хостинг от HostPro" src="https://billing.hostpro.ua/banners/general/Blue/468x60.png" title="Linux Хостинг от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span12">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/general/Blue/468x60.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">Общий баннер 468x60</h3>
     <div class="row-fluid">
       <div class="span12">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="Linux Хостинг от HostPro" src="https://billing.hostpro.ua/banners/general/Orange/468x60.png" title="Linux Хостинг от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span12">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/general/Orange/468x60.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">Общий баннер 728x90</h3>
     <div class="row-fluid">
       <div class="span12">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="Linux Хостинг от HostPro" src="https://billing.hostpro.ua/banners/general/Blue/728x90.png" title="Linux Хостинг от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span12">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/general/Blue/728x90.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">Общий баннер 728x90</h3>
     <div class="row-fluid">
       <div class="span12">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="Linux Хостинг от HostPro" src="https://billing.hostpro.ua/banners/general/728x90.jpg" title="Linux Хостинг от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span12">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/general/Orange/728x90.png">
       </div>
     </div>
   <hr style="padding: 20px 0 0 0;">
<!-- ================================================================================================================================================================
-->
 </div>
 <div class="tab-pane" id="tab3">
    <h3 style="text-align: left;">Linux Хостинг 120x600</h3>
     <div class="row-fluid">
       <div class="span8">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="Linux Хостинг от HostPro" src="https://billing.hostpro.ua/banners/ssd-hosting/120x600.png" title="Linux Хостинг от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span4">
       <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/ssd-hosting/120x600.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">Linux Хостинг 200x200</h3>     
     <div class="row-fluid">
       <div class="span8">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="Linux Хостинг от HostPro" src="https://billing.hostpro.ua/banners/ssd-hosting/200x200.png" title="Linux Хостинг от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span4">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/ssd-hosting/200x200.png">
       </div>
     </div> 
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">Linux Хостинг 250x250</h3>
     <div class="row-fluid">
       <div class="span8">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="Linux Хостинг от HostPro" src="https://billing.hostpro.ua/banners/ssd-hosting/250x250.png" title="Linux Хостинг от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span4">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/ssd-hosting/250x250.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">Linux Хостинг 300x250</h3>
     <div class="row-fluid">
       <div class="span8">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="Linux Хостинг от HostPro" src="https://billing.hostpro.ua/banners/ssd-hosting/300x250.png" title="Linux Хостинг от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span4">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/ssd-hosting/300x250.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">Linux Хостинг 300x600</h3>
     <div class="row-fluid">
       <div class="span8">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="Linux Хостинг от HostPro" src="https://billing.hostpro.ua/banners/ssd-hosting/300x600.png" title="Linux Хостинг от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span4">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/ssd-hosting/300x600.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">Linux Хостинг 336x280</h3>
     <div class="row-fluid">
       <div class="span7">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="Linux Хостинг от HostPro" src="https://billing.hostpro.ua/banners/ssd-hosting/336x280.png" title="Linux Хостинг от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span5">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/ssd-hosting/336x280.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">Linux Хостинг 468x60</h3>
     <div class="row-fluid">
       <div class="span12">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="Linux Хостинг от HostPro" src="https://billing.hostpro.ua/banners/ssd-hosting/468x60.png" title="Linux Хостинг от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span12">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/ssd-hosting/468x60.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">Linux Хостинг 728x90</h3>
     <div class="row-fluid">
       <div class="span12">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="Linux Хостинг от HostPro" src="https://billing.hostpro.ua/banners/ssd-hosting/728x90.png" title="Linux Хостинг от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span12">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/ssd-hosting/728x90.png">
       </div>
     </div>
   <hr style="padding: 20px 0 0 0;">
 </div>
<!-- ================================================================================================================================================================
-->
 <div class="tab-pane" id="tab4">
<!-- ================================================================================================================================================================
-->
   <h3 style="text-align: left;">SSD VPS + 120x600</h3>
     <div class="row-fluid">
       <div class="span8">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="SSD VPS от HostPro" src="https://billing.hostpro.ua/banners/VPS_plus/120x600.png" title="SSD VPS от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span4">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/VPS_plus/120x600.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">SSD VPS + 200x200</h3>     
     <div class="row-fluid">
       <div class="span8">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="SSD VPS от HostPro" src="https://billing.hostpro.ua/banners/VPS_plus/200x200.png" title="SSD VPS от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span4">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/VPS_plus/200x200.png">
       </div>
     </div> 
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">SSD VPS + 250x250</h3>
     <div class="row-fluid">
       <div class="span8">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="SSD VPS от HostPro" src="https://billing.hostpro.ua/banners/VPS_plus/250x250.png" title="SSD VPS от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span4">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/VPS_plus/250x250.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">SSD VPS + 300x250</h3>
     <div class="row-fluid">
       <div class="span8">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="SSD VPS от HostPro" src="https://billing.hostpro.ua/banners/VPS_plus/300x250.png" title="SSD VPS от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span4">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/VPS_plus/300x250.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">SSD VPS + 300x600</h3>
     <div class="row-fluid">
       <div class="span8">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="SSD VPS от HostPro" src="https://billing.hostpro.ua/banners/VPS_plus/300x600.png" title="SSD VPS от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span4">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/VPS_plus/300x600.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">SSD VPS + 336x280</h3>
     <div class="row-fluid">
       <div class="span7">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="SSD VPS от HostPro" src="https://billing.hostpro.ua/banners/VPS_plus/336x280.png" title="SSD VPS от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span5">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/VPS_plus/336x280.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">SSD VPS + 468x60</h3>
     <div class="row-fluid">
       <div class="span12">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="SSD VPS от HostPro" src="https://billing.hostpro.ua/banners/VPS_plus/468x60.png" title="SSD VPS от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span12">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/VPS_plus/468x60.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
-->
   <hr style="padding: 20px 0 0 0;">
    <h3 style="text-align: left;">SSD VPS + 728x90</h3>
     <div class="row-fluid">
       <div class="span12">
           <p style="text-align: left;">Код вставки:
             <pre>
&lt;a href="{$referrallink}"&gt;
  &lt;img alt="SSD VPS от HostPro" src="https://billing.hostpro.ua/banners/VPS_plus/728x90.png" title="SSD VPS от HostPro" /&gt;
&lt;/a&gt;
             </pre>
           </p>
       </div>
       <div class="span12">
        <p style="text-align: left;">Пример баннера:</p>
        <img src="https://billing.hostpro.ua/banners/VPS_plus/728x90.png">
       </div>
     </div>
<!-- ================================================================================================================================================================
--> 
   <hr style="padding: 20px 0 0 0;">    
</div>
<!-- ================================================================================================================================================================
-->
<div class="tab-pane" id="tab5">
{* uniweb end *}
  {$affiliatelinkscode}
{* uniweb start *}
</div>
</div>
{* uniweb end *}
</div>
{/if}
{/if}
