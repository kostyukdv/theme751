{assign var="label" value="default"}
{if $status|strstr:"779500"}{assign var="label" value="success"}
{elseif $status|strstr:"000000"}{assign var="label" value="primary"}
{elseif $status|strstr:"ff6600"}{assign var="label" value="warning"}
{elseif $status|strstr:"224488"}{assign var="label" value="info"}
{elseif $status|strstr:"cc0000"}{assign var="label" value="danger"}
{/if}

{if $error}
<p>{$LANG.supportticketinvalid}</p>
{else}

<h3 class="page-header">{$LANG.supportticketsviewticket|cat:' #'|cat:$tid}</h3>
<script>
{literal}
$(document)
.on('change', '.btn-file :file', function() {
  var input = $(this),
  numFiles = input.get(0).files ? input.get(0).files.length : 1,
  label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
  input.trigger('fileselect', [numFiles, label]);
});
$(document).ready( function() {
  $('.btn-file :file').on('fileselect', function(event, numFiles, label) {
    var input = $(this).parents('.input-group').find(':text'),
    log = numFiles > 1 ? numFiles + ' files selected' : label;
    if( input.length ) {
      input.val(log);
    } else {
      if( log ) alert(log);
    }
  });
});
{/literal}
</script>
{if $errormessage}
<div class="alert alert-danger">
  <p>{$LANG.clientareaerrors}</p>
  <ul>
    {$errormessage}
  </ul>
</div>
{/if}

<div class="alert alert-{$label} alert-block">
  <div class="alert-watermark m-1">
    <i class="fa fa-ticket fa-5x {if $label neq 'default'}fa-inverse{/if}"></i>
  </div>
  <h4>{$subject}</h4>
    <span class="mr-2"><span aria-hidden="true" class="icon icon-event"></span> {$date}</span>
    <span class="mr-2"><span aria-hidden="true" class="icon icon-people"></span>  {$department} </span>
    <span class="mr-2"><span aria-hidden="true" class="icon icon-fire"></span>  {$urgency|regex_replace:"/(<span>|<span [^>]*>|<\\/span>)/":""} {$LANG.supportticketspriority}</span>
    <span class="mr-0"><span aria-hidden="true" class="icon icon-tag"></span> {$status|strip_tags|replace:' ':''} {if $showclosebutton} (<a style="text-transform: lowercase;" href='{$smarty.server.PHP_SELF}?tid={$tid}&amp;c={$c}&amp;closeticket=true'>{$LANG.supportticketsclose}</a>) {/if}</span>

  </div>

  {if $customfields}
  <table class="table">
    {foreach from=$customfields item=customfield}
    <tr><td>{$customfield.name}:</td><td>{$customfield.value}</td></tr>
    {/foreach}
  </table>
  {/if}
<div class="btn-toolbar px-1 pb-2" role="toolbar"><button type="button" onclick="jQuery('#replycont').slideToggle()" class="btn btn-primary">{$LANG.supportticketsreply}</button></div>
  <div id="replycont" class="pb-2 clearfix {if !$smarty.get.postreply} subhide{/if}">
    <form method="post" action="{$smarty.server.PHP_SELF}?tid={$tid}&amp;c={$c}&amp;postreply=true" enctype="multipart/form-data" class="form-stacked">
            <div class="row {if $loggedin}subhidden{/if}">
              <div class="col-md-6">
                <div class="form-group">
                  <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-user"></i></span>
                    {if $loggedin}<input class="form-control disabled input-sm" type="text" id="name" value="{$clientname}" disabled="disabled" />{else}<input class="input-sm form-control" type="text" name="replyname" id="name" value="{$replyname}" />{/if}
                  </div>
                </div>
              </div>
              <div class="col-md-6">
                <div class="form-group">
                  <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                    {if $loggedin}<input class="form-control disabled input-sm" type="text" id="email" value="{$email}" disabled="disabled" />{else}<input class="input-sm form-control" type="text" name="replyemail" id="email" value="{$replyemail}" />{/if}</div>
                  </div>
                </div>
              </div>
              <div class="form-group">
                <div class="controls">
                  <textarea name="replymessage" id="message" class="form-control markdown-editor" data-auto-save-name="client_ticket_reply_{$tid}" placeholder="{$LANG.contactmessage}" rows="6">{$replymessage}</textarea>
                </div>
              </div>
              <div id="fileuploads" class="px-1 py-1">
                <div class="input-group input-group-sm">
                  <span class="input-group-btn">
                    <span class="btn btn-default btn-sm btn-file">
                      <span class="glyphicon glyphicon-folder-open"></span> <input type="file" name="attachments[]" multiple="">
                    </span>
                  </span>
                  <input type="text" class="form-control" readonly="">
                </div>
              </div>
              <span class="help-block px-1"><a href="#" class="btn btn-xs btn-default" onclick="extraTicketAttachment();return false"><span class="glyphicon glyphicon-plus-sign"></span> {$LANG.addmore}</a> <small> {$LANG.supportticketsallowedextensions}: {$allowedfiletypes}</small></span>
            <input type="submit" value="{$LANG.supportticketsticketsubmit}" class="btn btn-primary pull-right flip mx-1" />
      </form>
   </div>
    <div class="panel panel-default panel-tickets">
      {foreach from=$descreplies key=num item=reply}
      <div class="{if $reply.admin}admin{else}client{/if}header panel-heading markdown-content">
        <div class="pull-right flip"><h6 style="margin-top:10px;"><i class="fa fa-clock-o"></i> {$reply.date}</h6></div>
        <h4 class="panel-title">{if $reply.admin}
          <img src="https://www.gravatar.com/avatar/{if isset($descreplies_reply_admin_email[$reply.id])}{md5(strtolower(trim(   $descreplies_reply_admin_email[$reply.id]   )))}{else}{md5(strtolower(trim($reply.email)))}{/if}?s=30&d=mm" class="mr-1" alt="">{$reply.name} <span class="badge badge-warning">{$LANG.supportticketsstaff}</span>
          {elseif $reply.contactid}
          {$reply.name} <span class="badge">{$LANG.supportticketscontact}</span>
          {elseif $reply.userid}
          <img src="https://www.gravatar.com/avatar/{md5(strtolower(trim($reply.email)))}?s=30&d=mm" class="mr-1" alt="">{$reply.name}
          {else}
          {$reply.name} <span class="badge">{$reply.email}</span>
          {/if}</h4>
        </div>
        <div class="{if $reply.admin}admin{else}client{/if}msg panel-body">
          <p>{$reply.message}</p>
          {if $reply.attachments}
          <div class="well well-sm">
            <h4><span class="glyphicon glyphicon-floppy-disk" style="color:#aaa;"></span> {$LANG.supportticketsticketattachments}:</h4>
            {foreach from=$reply.attachments key=num item=attachment}
            <a href="dl.php?type={if $reply.id}ar&id={$reply.id}{else}a&id={$id}{/if}&i={$num}">{$attachment}</a>
            {/foreach}
          </div>
          {/if}
          {if $reply.id && $reply.admin && $ratingenabled}
          {if $reply.rating}
          <table class="ticketrating" align="right">
            <tr>
              <td>{$LANG.ticketreatinggiven}&nbsp;</td>
              {foreach from=$ratings item=rating}
              <td><span class="glyphicon glyphicon-star{if $reply.rating>=$rating}{else}-empty{/if}"></span></td>
              {/foreach}
            </tr>
          </table>
          {else}
          <table class="ticketrating" align="right">
            <tr onmouseout="rating_leave('rate{$reply.id}')">
              <td>{$LANG.ticketratingquestion}&nbsp;</td>
              {foreach from=$ratings item=rating}
              <td class="" id="rate{$reply.id}_{$rating}" onmouseover="rating_hover(this.id)" onclick="rating_select('{$tid}','{$c}',this.id)"><span class="glyphicon glyphicon-star-empty"></span></td>
              {/foreach}
            </tr>
          </table>
          {/if}
          {/if}
        </div>
        {/foreach}
      </div>
    {/if}
