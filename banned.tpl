{include file="$template/pageheader.tpl" title=$LANG.accessdenied icon=ban}
<div class="alert alert-danger">
<p>{$LANG.bannedyourip} {$ip} {$LANG.bannedhasbeenbanned}</p>
    <ul>
        <li>{$LANG.bannedbanreason}: <strong>{$reason}</strong></li>
    	<li>{$LANG.bannedbanexpires}: {$expires}</li>
    </ul>
</div>
