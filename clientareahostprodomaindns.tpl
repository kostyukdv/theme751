{include file="$template/pageheader.tpl" title=$LANG.domaindnsmanagement}

<div class="alert alert-block alert-info">
    <p>{$LANG.domainname}: <strong>{$domain}</strong></p>
</div>

<p>{$LANG.domaindnsmanagementdesc}</p>

<br />

{if $errors}
<div class="alert alert-block alert-danger">
    <p>{$errors}</p>
</div>
{/if}

{if $correctns}

    {if ($ns_not_updated)}
    <p style="color:red">Изменения вступят в силу после того как обновится информация на корневых DNS серверах</p>
    {/if}

    <form method="post" action="{$smarty.server.PHP_SELF}?domainid={$domainid}" onsubmit="return window.confirm('Вы действительно хотите сохранить изменения?')">
    <input type="hidden" name="sub" value="save" />

    {literal}
    <script>
    function handleDnsTypeChange(id, dnsId) {
        var obj = document.getElementById('dnstype_'+id);   
        var displayPriority = 'none';
        var displayWeight = 'none';
        var displayPort = 'none';
        var maxLength = 64000;
        if (obj.value == "MX" || obj.value == "SRV") {
            displayPriority = 'block';      
        }   
        document.getElementById('dnspriority_'+id).style.display = displayPriority;
        //
        if (obj.value == "SRV") {
            displayWeight = 'block';
            displayPort = 'block';
        }
        document.getElementById('dnsweight_'+id).style.display = displayWeight;
        document.getElementById('dnsport_'+id).style.display = displayPort;
        if (obj.value == "TXT") {
        	$('input[name="dnsrecordaddress['+dnsId+']"]').prop('maxlength' , maxLength);
        }
        else {
        	$('input[name="dnsrecordaddress['+dnsId+']"]').removeAttr('maxlength');
        }
    }

    function displayNewRecord() {
        document.getElementById('dnsrecordhost_new').style.visibility = 'visible';
        document.getElementById('dnsrecordttl_new').style.visibility = 'visible';
        document.getElementById('dnsrecordtype_new').style.visibility = 'visible';
        document.getElementById('dnsrecordpriority_new').style.visibility = 'visible';
        document.getElementById('dnsrecordweight_new').style.visibility = 'visible';
        document.getElementById('dnsrecordport_new').style.visibility = 'visible';
        document.getElementById('dnsrecordaddress_new').style.visibility = 'visible';
        document.getElementById('is_add_record').value = 1;
    }
    var wasTtlAlert = 0;
    function ttlMessage(status) {
        if (wasTtlAlert == 0) {
            alert('Если Вы не уверены в своих действиях, не изменяйте значение TTL');
            wasTtlAlert = 1;
        }
    }
    </script>
    {/literal}

    <table class="table table-striped table-framed" align="center" cellspacing="1">
    <tr class="clientareatableheading"><th align="center">Домен</th><th>TTL</th><th>Тип</th><th>Приоритет</th><th><div style="width:65px">Вес</div></th><th><div style="width:65px">Порт</div></th><th>Адрес</th><th></th></tr>
    {foreach key=num item=dnsrecord from=$dnsrecords}
    <tr class="clientareatableactive">
        <td style="padding:0 2px;"><nobr><input type="text" name="dnsrecordhost[{$dnsrecord.id}]" value="{if $dnsrecord.hostname eq ''}@{else}{$dnsrecord.hostname}{/if}" size="10" style="width: 60px"/>.{$domain}</nobr></td>
        <td>
            <input type="text" name="dnsrecordttl[{$dnsrecord.id}]" style="width: 40px" value="{if ($dnsrecord.ttl eq "0")}{else}{$dnsrecord.ttl}{/if}" style="width:88px;" onclick="ttlMessage(true);"/>
        </td>
        <td>
            <select onchange="javascript:handleDnsTypeChange({$num}, {$dnsrecord.id})" id="dnstype_{$num}" name="dnsrecordtype[{$dnsrecord.id}]">
            <option value="A"{if $dnsrecord.type eq "A"} selected="selected"{/if}>A (Address)</option>
            <option value="AAAA"{if $dnsrecord.type eq "AAAA"} selected="selected"{/if}>AAAA</option>
            <option value="MX"{if $dnsrecord.type eq "MX"} selected="selected"{/if}>MX (Mail)</option>
            <option value="CNAME"{if $dnsrecord.type eq "CNAME"} selected="selected"{/if}>CNAME (Alias)</option>
            <option value="REDIRECT"{if $dnsrecord.type eq "REDIRECT"} selected="selected"{/if}>REDIRECT</option>
            <option value="TXT"{if $dnsrecord.type eq "TXT"} selected="selected"{/if}>TXT</option>
            <option value="SPF"{if $dnsrecord.type eq "SPF"} selected="selected"{/if}>SPF</option>
            <option value="SRV"{if $dnsrecord.type eq "SRV"} selected="selected"{/if}>SRV</option>
            </select>
        </td>
        <td width="75px">
            <div id="dnspriority_{$num}" {if ($dnsrecord.type eq "MX" || $dnsrecord.type eq "SRV")}style="display:block"{else}style="display:none"{/if}><input type="text" name="dnspriority[{$dnsrecord.id}]" style="width: 40px;" value="{$dnsrecord.priority}" size="8" /></div>
        </td>
        <td width="75px">
            <div id="dnsweight_{$num}" {if ($dnsrecord.type eq "SRV")}style="display:block"{else}style="display:none"{/if}><input type="text" name="dnsweight[{$dnsrecord.id}]" value="{$dnsrecord.weight}" size="8" style="width: 40px;" /></div>
        </td>
        <td width="75px">
            <div id="dnsport_{$num}" {if ($dnsrecord.type eq "SRV")}style="display:block"{else}style="display:none"{/if}><input type="text" name="dnsport[{$dnsrecord.id}]" value="{$dnsrecord.port}" size="8" style="width: 40px;"/></div>
        </td>
        <td>
            <input type="text" name="dnsrecordaddress[{$dnsrecord.id}]" value="{$dnsrecord.address|htmlspecialchars}" size="30" style="width: 180px;" />
        </td>
        <td>
            <input class="btn btn-danger" type="button" name="delete_{$num}" value="Удалить" onclick="javascript:if (window.confirm('Вы действительно хотите удалить эту запись?')) document.location.href='domaindns.php?domainid={$domainid}&sub=delete&dns_id={$dnsrecord.id}';" />
        </td>
    </tr>
    {/foreach}
    <tr class="clientareatableactive">
        <td id="dnsrecordhost_new" width="120px" style="padding:0 2px; visibility:hidden">
            <nobr><input type="text" name="dnsrecordhost_new" value="{$postData.dnsrecordhost_new|htmlspecialchars}" size="10" style="width: 60px" />.{$domain}</nobr>
        </td>
        <td id="dnsrecordttl_new" style="visibility:hidden">
            <input type="text" name="dnsrecordttl_new" value="{$postData.dnsrecordttl_new|htmlspecialchars}" style="width:40px;" />
        </td>
        <td id="dnsrecordtype_new" style=" visibility:hidden">
            <select onchange="javascript:handleDnsTypeChange('new')" id="dnstype_new" name="dnsrecordtype_new">
            <option value="A"{if $postData.dnsrecordtype_new eq "A"} selected="selected"{/if}>A (Address)</option>
            <option value="AAAA"{if $postData.dnsrecordtype_new eq "AAAA"} selected="selected"{/if}>AAAA</option>
            <option value="MX"{if $postData.dnsrecordtype_new eq "MX"} selected="selected"{/if}>MX (Mail)</option>
            <option value="CNAME"{if $postData.dnsrecordtype_new eq "CNAME"} selected="selected"{/if}>CNAME (Alias)</option>
            <option value="REDIRECT"{if $postData.dnsrecordtype_new eq "REDIRECT"} selected="selected"{/if}>REDIRECT</option>
            <option value="TXT"{if $postData.dnsrecordtype_new eq "TXT"} selected="selected"{/if}>TXT</option>
            <option value="SPF"{if $postData.dnsrecordtype_new eq "SPF"} selected="selected"{/if}>SPF</option>
            <option value="SRV"{if $postData.dnsrecordtype_new eq "SRV"} selected="selected"{/if}>SRV</option>
            </select>
        </td>
        <td id="dnsrecordpriority_new" style=" visibility:hidden" width="75px">
            <div id="dnspriority_new" style="display:none"><input type="text" name="dnspriority_new" value="{if ($postData.dnspriority_new)}{$postData.dnspriority_new|htmlspecialchars}{else}0{/if}" size="8" style="width: 20px"/></div>
        </td>   
        
        <td id="dnsrecordweight_new" style=" visibility:hidden" width="75px">
            <div id="dnsweight_new" style="display:none"><input type="text" name="dnsweight_new" value="{if ($postData.dnsweight_new)}{$postData.dnsweight_new|htmlspecialchars}{else}0{/if}" size="8" style="width: 20px"/></div>
        </td>   
        
        <td id="dnsrecordport_new" style=" visibility:hidden" width="75px">
            <div id="dnsport_new" style="display:none"><input style="width: 20px" type="text" name="dnsport_new" value="{if ($postData.dnsport_new)}{$postData.dnsport_new|htmlspecialchars}{else}0{/if}" size="8" /></div>
        </td>   
        
        
        <td id="dnsrecordaddress_new" style=" visibility:hidden">
            <input type="text" name="dnsrecordaddress_new" style="width: 180px" value="{$postData.dnsrecordaddress_new|htmlspecialchars}" size="30" />
        </td>   
        <td>
            <input type="button" value="Добавить" class="btn btn-primary"  onclick="javascript:displayNewRecord()" />
        </td>
    </tr>
    </table>

    <input type="hidden" id="is_add_record" name="is_add_record" value="0">

    <script>
    {if ($add_dnsrecord)}
    displayNewRecord();
    {/if}
    </script>

    <p align="center"><input type="submit" value="{$LANG.clientareasavechanges}" class="btn btn-success" /></p>

    </form>

    <p align="left"><a href="/clientarea.php?action=domaindetails&id={$domainid}" class="btn btn-default">{$LANG.clientareabacklink}</a></p>

    <h3>Примечания</h3>

    <p style="font-weight:bold">A-запись: необходимо, чтобы сайт открывался с другого сервера</p>
    <p>Если это нужно сделать для домена {$domain}, создайте запись вида:</p>
    <ul>
        <li>Имя хоста: @</li>
        <li>Тип записи: A</li>
        <li>Адрес: IP-адрес сервера</li>
    </ul>

    <p>Если это нужно сделать для поддомена домена {$domain}, создайте запись вида:</p>
    <ul>
        <li>Имя хоста: abc («abc» указано в качестве примера. Работает, если вы хотите создать запись для домена abc.{$domain} в зоне домена {$domain}. В вашем случае будет какое-то другое имя)</li>
        <li>Тип записи: A</li>
        <li>Адрес: IP-адрес сервера</li>
    </ul>
       
    <br/>
    <p style="font-weight:bold">MX-запись: необходимо, чтобы почта домена обслуживалась другим сервером</p>
    <p>Если вы хотите изменить почтовый сервер для домена {$domain}, создайте запись вида:</p>
    <ul>
        <li>Имя хоста: @</li>
        <li>Тип записи: MX</li>
        <li>MX preference: числовое значение, допустим, 10.</li>
        <li>Адрес: имя почтового сервера</li>
    </ul>

    <p>Если имя почтового сервера, поддомен домена {$domain}, тогда необходимо еще создать запись вида:</p>
    <ul>
        <li>Имя хоста: имя почтового сервера</li>
        <li>Тип записи: A</li>
        <li>Адрес: IP-адрес почтового сервера</li>
    </ul>
{else}
    <div class="errorbox">Для управления доменом смените NS-сервера на ns1.hostpro.ua и ns2.hostpro.ua</div><br />
    
    <center>
        <a class="btn btn-primary" href="/clientarea.php?action=domaindetails&id={$domainid}#tab3">Изменить</a>
        <a class="btn btn-default" href="/clientarea.php?action=domaindetails&id={$domainid}">Назад</a>
    </center>
{/if}
