{* IMPORTANT! FILE WITH CUSTOM CHANGES *}
{* hostpro start *}
<h3>{$LANG.domaincontactinfo} - {$domain}</h3>
{include file="$template/pageheader.tpl" title=$LANG.domaincontactinfo}
{include file="$template/includes/alert.tpl" type="warning" msg="<b>Внимание!</b> Согласно правилам администратора зоны - в домене должны быть указаны достоверные данные владельца домена. Пожалуйста, укажите Ваши контактные данные на английском языке. Ложные или недостоверные контактные данные могут быть основанием для отмены регистрации вашего доменного имени администратором зоны."}
{include file="$template/includes/alert.tpl" type="info" msg=$LANG.whoisContactWarning}
{if $successful}
{include file="$template/includes/alert.tpl" type="success" msg=$LANG.changessavedsuccessfully}
{/if}

{if $error}
	{include file="$template/includes/alert.tpl" type="error" msg="Для уточнения процедуры изменения контактных данных Вашего домена обратитесь в отдел продаж sales@hostpro.ua" textcenter=true}
{/if}
{* hostpro end *}
<form method="post" action="{$smarty.server.PHP_SELF}?action=domaincontacts">
  <input type="hidden" name="sub" value="save" />
  <input type="hidden" name="domainid" value="{$domainid}" />
  <div class="row">
    {foreach from=$contactdetails name=contactdetails key=contactdetail item=values}
    <div class="col-md-6 col-md-offset-3">
      <h4>{$contactdetail} {$LANG.supportticketscontact}</h4>
      <div class="radio">
        <label>
          <input type="radio" name="wc[{$contactdetail}]" id="{$contactdetail}1" value="contact" onclick="useDefaultWhois(this.id)" />
          {$LANG.domaincontactusexisting}
        </label>
      </div>
      <div class="row">
        <div class="col-md-12">
          <div class="form-group">
            <label for="{$contactdetail}3">{$LANG.domaincontactchoose}</label>
            <select id="{$contactdetail}3" class="form-control {$contactdetail}defaultwhois" name="sel[{$contactdetail}]" disabled>
              <option value="u{$clientsdetails.userid}">{$LANG.domaincontactprimary}</option>
              {foreach key=num item=contact from=$contacts}
              <option value="c{$contact.id}">{$contact.name}</option>
              {/foreach}
            </select>
          </div>
        </div>
      </div>
      <div class="radio">
        <label>
          <input type="radio" name="wc[{$contactdetail}]" id="{$contactdetail}2" value="custom" onclick="useCustomWhois(this.id)" checked />
          {$LANG.domaincontactusecustom}
        </label>
      </div>
      {foreach key=name item=value from=$values}
      <div class="form-group">
        <label>{$name}</label>
        <input type="text" name="contactdetails[{$contactdetail}][{$name}]" value="{$value}" class="form-control {$contactdetail}customwhois" />
      </div>
      {/foreach}
    </div>
    {/foreach}
  </div>
  <div class="row">
    <div class="col-md-6 col-md-offset-3">
      <div class="form-group">
        <input type="submit" value="{$LANG.clientareasavechanges}" class="btn btn-primary btn-lg btn-block" />
      </div>
    </div>
  </div>
</form>
