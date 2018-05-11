{include file="$template/pageheader.tpl" title=$LANG.domainemailforwarding desc=$LANG.domainemailforwardingdesc}

<div class="alert alert-info">
<h4>{$LANG.domainname}: {$domain}</h4>
<form method="post" action="{$smarty.server.PHP_SELF}?action=domaindetails">
    <input type="hidden" name="id" value="{$domainid}" />
    <input type="submit" value="{$LANG.clientareabacklink}" class="btn btn-default" />
</form>
</div>
{if $error}
<div class="alert alert-danger">
    {$error}
</div>
{/if}
{if $external}
<div class="well">
    {$code}
</div>
{else}
<form method="post" action="{$smarty.server.PHP_SELF}?action=domainemailforwarding">
    <input type="hidden" name="sub" value="save" />
    <input type="hidden" name="domainid" value="{$domainid}" />

        <table class="table table-striped">
                <tr>
                    <td width="55%">{$LANG.domainemailforwardingprefix}</td>
                    <td width="45%">{$LANG.domainemailforwardingforwardto}</td>
                </tr>
                {foreach key=num item=emailforwarder from=$emailforwarders}
                <tr>
                    <td>
                    <div class="input-group">
                    <input type="text" class="form-control" name="emailforwarderprefix[{$num}]" value="{$emailforwarder.prefix}" />
                    <span class="input-group-addon"> @{$domain}</span>
                    </div>
                    </td>
                    <td><input type="text" class="form-control" name="emailforwarderforwardto[{$num}]" value="{$emailforwarder.forwardto}" /></td>
                </tr>
                {/foreach}
                <tr>
                    <td>
                    <div class="input-group">
                    <input type="text" class="form-control" name="emailforwarderprefixnew" />
                    <span class="input-group-addon"> @{$domain}</span>
                    </div>
                    </td>
                    <td><input type="text" class="form-control" name="emailforwarderforwardtonew" /></td>
                </tr>
        </table>
    <div class="p-1">
    <input type="submit" value="{$LANG.clientareasavechanges}" class="btn btn-primary" />
  </div>
</form>
{/if}
