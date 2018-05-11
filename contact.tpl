{if $hexa_minimal == 0}
{include file="$template/pageheader.tpl" title=$LANG.contacttitle icon='paper-plane'}
{/if}
<div class="row py-1">
      <div class="col-md-4 col-md-offset-4 box">
        <div class="content-wrap">
          {if $hexa_minimal == 1}<h6>{$LANG.contacttitle}</h6>{/if}
          {if $sent}
          <p class="text-success bg-success text-alert"><strong><span aria-hidden="true" class="icon icon-paper-plane"></span> {$LANG.contactsent}</strong></p>
          {else}
          {if $errormessage}
          <p class="text-danger bg-danger text-alert"><strong> <span aria-hidden="true" class="icon icon-ban"></span> {$LANG.warning}</strong></p>
          <ul class="list-unstyled">{$errormessage}</ul>
          {/if}
          <form method="post" action="contact.php?action=send" name="frmcontact">
            <div class="form-group">
              <div class="input-group input-group-lg">
                <span class="input-group-addon"><span aria-hidden="true" class="icon icon-user"></span></span>
                <input type="text" name="name" id="name" class="form-control" value="{$name}" placeholder="{$LANG.supportticketsclientname}"/>
              </div>
            </div>
            <div class="form-group">
              <div class="input-group input-group-lg">
                <span class="input-group-addon"><span aria-hidden="true" class="icon icon-envelope"></span></span>
                <input type="email" name="email" id="email" class="form-control" value="{$email}" placeholder="{$LANG.supportticketsclientemail}" required />
              </div>
            </div>
            <div class="form-group">
              <input type="text" name="subject" id="subject" class="form-control input-lg" value="{$subject}" placeholder="{$LANG.supportticketsticketsubject}"/>
            </div>
            <div class="form-group">
              <textarea name="message" id="message" rows="5" class="form-control input-lg" placeholder="{$LANG.contactmessage}">{$message}</textarea>
            </div>
            <div class="form-group">
                    {include file="$template/includes/captcha.tpl"}
            </div>
            <div class="row">
           <div class="col-md-12">
	   <div class="form-group">
            <button type="submit" class="btn btn-lg btn-primary btn-block">{$LANG.contactsend}</button>
            </div>
	    </div>
            </div>
          </form>
          {/if}
        </div>
      </div>
    </div>
    {if $hexa_minimal == 1}
    <div class="languageblock">
    {include file="$template/languageblock.tpl"}
    </div>
    {/if}
