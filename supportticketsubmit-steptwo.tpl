{include file="$template/pageheader.tpl" title=$LANG.navopenticket desc=$LANG.supportticketsintro icon=support}
<script>
	var currentcheckcontent,lastcheckcontent;
	{if $kbsuggestions}
	{literal}
	function getticketsuggestions() {
		currentcheckcontent = jQuery("#message").val();
		if (currentcheckcontent!=lastcheckcontent && currentcheckcontent!="") {
			jQuery.post("submitticket.php", { action: "getkbarticles", text: currentcheckcontent },
				function(data){
					if (data) {
						jQuery("#searchresults").html(data);
						jQuery("#searchresults").slideDown();
					}
				});
			lastcheckcontent = currentcheckcontent;
		}
		setTimeout('getticketsuggestions();', 3000);
	}
	getticketsuggestions();
	{/literal}
	{/if}
{literal}
$( document ).ready(function() {
    getCustomFields();
});

function getCustomFields() {
    /**
     * Load the custom fields for the specific department
     */
    jQuery("#department").prop('disabled', true);
    jQuery("#customFields").load(
        "submitticket.php",
        { action: "getcustomfields", deptid: jQuery("#department").val() }
    );
    jQuery("#customFields").slideDown();
    jQuery("#department").prop('disabled', false);
}
{/literal}
</script>
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
<form name="submitticket" method="post" action="{$smarty.server.PHP_SELF}?step=3" enctype="multipart/form-data">
	<div class="row py-2">
	<div class="{*col-md-6 col-md-offset-3*}col-md-10 col-sm-12">
		<div class="row">
			<div class="col-md-6">
			<div class="form-group {*hostpro start*}st-input{*hostpro end*}">
				{*<div class="input-group">*}
					{*<span class="input-group-addon"><span class="glyphicon glyphicons-tree-structure"></span> </span>*}
                                        <label for="name">{$LANG.supportticketschoosedepartment}</label>
					<select name="deptid" class="form-control" id="department" disabled onchange="getCustomFields()">{foreach from=$departments item=department}<option value="{$department.id}"{if $department.id eq $deptid} selected{/if}>{$department.name}</option>{/foreach}</select>
				{*</div>*}
				</div>
			</div>
			<div class="col-md-6">
			<div class="form-group {*hostpro start*}st-input{*hostpro end*}">
				{*<div class="input-group">*}
					{*<span class="input-group-addon"><span class="glyphicon glyphicon-fire"></span> </span>*}
                                        <label for="name">{$LANG.supportticketsticketurgency}</label>
					<select name="urgency" class="form-control" id="priority"><option value="High"{if $urgency eq "High"} selected{/if}>{$LANG.supportticketsticketurgencyhigh}</option><option value="Medium"{if $urgency eq "Medium" || !$urgency} selected{/if}>{$LANG.supportticketsticketurgencymedium}</option><option value="Low"{if $urgency eq "Low"} selected{/if}>{$LANG.supportticketsticketurgencylow}</option></select>
				{*</div>*}
				</div>
				</div>
				</div>
					<div class="row {if $loggedin}subhidden{/if}">
						<div class="col-md-6">
							<label for="name">{$LANG.supportticketsclientname}</label>
							<div class="form-group {*hostpro start*}st-input{*hostpro end*}">
								{if $loggedin}<input type="text" name="name" id="name" value="{$clientname}" disabled class="form-control">{else}<input type="text" name="name" id="name" value="{$name}" class="form-control">{/if}
							</div>
						</div>
						<div class="col-md-6">
							<label for="email">{$LANG.supportticketsclientemail}</label>
							<div class="form-group {*hostpro start*}st-input{*hostpro end*}">
								{if $loggedin}<input type="text" name="email" id="email" value="{$email}" disabled class="form-control">{else}<input type="text" name="email" id="email" value="{$email}" class="form-control">{/if}
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-12">
							<label for="subject">{$LANG.supportticketsticketsubject}</label>
							<div class="form-group {*hostpro start*}st-input{*hostpro end*}">
								<input class="form-control" type="text" name="subject" id="subject" value="{$subject}"/>
							</div>
						</div>
					</div>
					{if $relatedservices}
					<div class="row">
						<div class="col-lg-12">
							<label for="relatedservice">{$LANG.relatedservice}</label>
							<div class="form-group {*hostpro start*}st-input{*hostpro end*}">
								<select name="relatedservice" class="form-control" id="relatedservice">
									<option value="">{$LANG.none}</option>
									{foreach from=$relatedservices item=relatedservice}
									<option value="{$relatedservice.id}">{$relatedservice.name} ({$relatedservice.status})</option>
									{/foreach}
								</select>
							</div>
						</div>
					</div>
					{/if}
					<div class="row">
						<div class="col-lg-12">
							<label for="message">{$LANG.contactmessage}</label>
							<div class="form-group">
								<textarea name="message" id="message" rows="10" class="form-control markdown-editor" data-auto-save-name="client_ticket_open">{$message}</textarea>
							</div>
						</div>
					</div>
					<div id="searchresults" class="contentbox well well-sm" style="display:none;"></div>
					<div id="customFields" class="contentbox" style="display:none;"></div>
					<div id="fileuploads">
					<div class="form-group">
					<label>{$LANG.supportticketsticketattachments}</label> <a href="javascript:void(0)" data-toggle="tooltip" title="{$LANG.supportticketsallowedextensions}: {$allowedfiletypes}" data-original-title="{$LANG.supportticketsallowedextensions}: {$allowedfiletypes}"><span class="glyphicon glyphicon-question-sign"></span></a>
							<div class="input-group input-group-sm">
								<span class="input-group-btn">
									<span class="btn btn-default btn-file">
										<span class="glyphicon glyphicon-folder-open"></span> <input type="file" name="attachments[]" multiple="">
									</span>
								</span>
								<input type="text" class="form-control" readonly="">
								<span class="input-group-btn">
									<a href="#" class="btn btn-default btn-file" onclick="extraTicketAttachment();return false"><span class="glyphicon glyphicon-plus-sign"></span> {$LANG.addmore}</a>
								</span>
							</div>
						</div>
						</div>
						{include file="$template/includes/captcha.tpl"}
						<div class="row">
							<div class="col-md-12">
								<input class="btn btn-primary btn-lg btn-block" type="submit" name="save" id="openTicketSubmit" value="{$LANG.supportticketsticketsubmit}" />
							</div>
						</div>
					</div>
				</div>
			</form>
