<script>
	{literal}
	$(function () { $("[data-toggle='tooltip']").tooltip(); });
	{/literal}
</script>
{foreach key=num item=customfield from=$customfields}
<div class="form-group">
<label for="customfield{$customfield.id}">{$customfield.name} <a href="javascript:void(0)" data-toggle="tooltip" title="{$customfield.description}" data-original-title="{$customfield.description}"><span class="glyphicon glyphicon-question-sign"></span></a></label> 
{$customfield.input}						
</div>
{/foreach}