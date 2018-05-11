{include file="$template/pageheader.tpl" title=$LANG.networkstatustitle desc=$LANG.networkstatusintro icon=feed}
<div class="row px-1 pt-1">
	<div class="col-md-4">
    <a href="{$smarty.server.PHP_SELF}?view=open">
		<div class="info-box  bg-info  text-white">
			<div class="info-icon bg-info-dark">
				<span aria-hidden="true" class="icon icon-folder-alt"></span>
			</div>
			<div class="info-details">
				<h4>{$LANG.networkissuesstatusopen}</h4>
				<p><span class="badge">{$opencount}</span></p>
			</div>
		</div>
    </a>
	</div>
	<div class="col-md-4">
    <a href="{$smarty.server.PHP_SELF}?view=scheduled">
		<div class="info-box  bg-warn  text-white">
			<div class="info-icon bg-warn-dark">
				<span aria-hidden="true" class="icon icon-event"></span>
			</div>
			<div class="info-details">
				<h4>{$LANG.networkissuesstatusscheduled}</h4>
				<p><span class="badge">{$scheduledcount}</span></p>
			</div>
		</div>
  </a>
	</div>
	<div class="col-md-4">
    <a href="{$smarty.server.PHP_SELF}?view=resolved">
		<div class="info-box  bg-inactive  text-white">
			<div class="info-icon bg-inactive-dark">
				<span aria-hidden="true" class="icon icon-folder"></span>
			</div>
			<div class="info-details">
				<h4>{$LANG.networkissuesstatusresolved}</h4>
				<p><span class="badge">{$resolvedcount}</span></p>
			</div>
		</div>
	</div>
</a>
</div>
<hr>


<div class="row px-1">
<div class="col-md-12">

{foreach from=$issues item=issue}

{if $issue.clientaffected}
<div class="alert-message block-message alert-warning">
  {/if}
  <h3>{$issue.title} ({$issue.status})</h3>
  <p><strong>{$LANG.networkissuesaffecting} {$issue.type}</strong> - {if $issue.type eq $LANG.networkissuestypeserver}{$issue.server}{else}{$issue.affecting}{/if} | <strong>{$LANG.networkissuespriority}</strong> - {$issue.priority}</span></p>
  <blockquote>
    {$issue.description}
  </blockquote>
  <p><strong>{$LANG.networkissuesdate}</strong> - {$issue.startdate}{if $issue.enddate} - {$issue.enddate}{/if}</p>
  <p><strong>{$LANG.networkissueslastupdated}</strong> - {$issue.lastupdate}</p>

  {if $issue.clientaffected}</div>{/if}

  {foreachelse}

  <p><small>{$noissuesmsg}</small></p>

  {/foreach}

  <ul class="pagination">
    <li class="prev{if !$prevpage} disabled{/if}"><a href="{if $prevpage}{$smarty.server.PHP_SELF}?{if $view}view={$view}&amp;{/if}page={$prevpage}{else}javascript:return false;{/if}">&larr; {$LANG.previouspage}</a></li>
    <li class="next{if !$nextpage} disabled{/if}"><a href="{if $nextpage}{$smarty.server.PHP_SELF}?{if $view}view={$view}&amp;{/if}page={$nextpage}{else}javascript:return false;{/if}">{$LANG.nextpage} &rarr;</a></li>
  </ul>

  {if $servers}

  {include file="$template/subheader.tpl" title=$LANG.serverstatustitle}

  <p>{$LANG.serverstatusheadingtext}</p>

  {literal}
  <script>
    function getStats(num) {
      jQuery.post('serverstatus.php', 'getstats=1&num='+num, function(data) {
        jQuery("#load"+num).html(data.load);
        jQuery("#uptime"+num).html(data.uptime);
      },'json');
    }
    function checkPort(num,port) {
      jQuery.post('serverstatus.php', 'ping=1&num='+num+'&port='+port, function(data) {
        jQuery("#port"+port+"_"+num).html(data);
      });
    }
  </script>
  {/literal}

  <table class="table table-striped table-framed">
    <thead>
      <tr>
        <th>{$LANG.servername}</th>
        <th>HTTP</th>
        <th>FTP</th>
        <th>POP3</th>
        <th>{$LANG.serverstatusphpinfo}</th>
        <th>{$LANG.serverstatusserverload}</th>
        <th>{$LANG.serverstatusuptime}</th>
      </tr>
    </thead>
    <tbody>
      {foreach from=$servers key=num item=server}
      <tr>
        <td>{$server.name}</td>
        <td id="port80_{$num}"><img src="images/loadingsml.gif" alt="{$LANG.loading}" /></td>
        <td id="port21_{$num}"><img src="images/loadingsml.gif" alt="{$LANG.loading}" /></td>
        <td id="port110_{$num}"><img src="images/loadingsml.gif" alt="{$LANG.loading}" /></td>
        <td><a href="{$server.phpinfourl}" target="_blank">{$LANG.serverstatusphpinfo}</a></td>
        <td id="load{$num}"><img src="images/loadingsml.gif" alt="{$LANG.loading}" /></td>
        <td id="uptime{$num}"><img src="images/loadingsml.gif" alt="{$LANG.loading}" /><script> checkPort({$num},80); checkPort({$num},21); checkPort({$num},110); getStats({$num}); </script></td>
      </tr>
      {foreachelse}
      <tr>
        <td colspan="7">{$LANG.serverstatusnoservers}</td>
      </tr>
      {/foreach}
    </tbody>
  </table>
  {/if}
{if $loggedin}<div class="alert alert-info"><p>{$LANG.networkissuesaffectingyourservers}</p></div>{/if}
</div>
</div>
