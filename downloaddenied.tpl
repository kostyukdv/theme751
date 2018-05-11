{if $reason eq "supportandupdates"}
{include file="$template/pageheader.tpl" title="Support & Updates Expired"}
<div class="alert alert-info">
<p>Your Support & Updates period for {if $licensekey}license key "{$licensekey}"{else}this license{/if} has expired</p>
<p>Support and updates access needs to be renewed before you can access this download.</p>
<form action="{$systemsslurl}cart.php?a=add" method="post">
  <input type="hidden" name="productid" value="{$serviceid}" />
  <input type="hidden" name="aid" value="{$addonid}" />
  <p align="center"><input type="submit" value="Click Here to Renew &raquo;" class="btn" /></p>
</form>
</div>
{else}
{include file="$template/pageheader.tpl" title=$LANG.accessdenied}
<p>{$LANG.downloadproductrequired}</p>
<div class="alert alert-block alert-info">
  <p class="textcenter"><strong>{if $prodname}{$prodname}{else}{$addonname}{/if}</strong></p>
</div>
{if $pid || $aid}
<form action="{$systemsslurl}cart.php" method="post">
  {if $pid}
  <input type="hidden" name="a" value="add" />
  <input type="hidden" name="pid" value="{$pid}" />
  {elseif $aid}
  <input type="hidden" name="gid" value="addons" />
  {/if}
  <p><input type="submit" value="{$LANG.ordernowbutton} &raquo;" class="btn btn-default" />
  </form>
  {/if}
  {/if}
