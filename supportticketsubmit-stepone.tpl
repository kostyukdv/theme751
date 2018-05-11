{include file="$template/pageheader.tpl" title=$LANG.navopenticket desc=$LANG.supportticketsheader icon=support}
<div class="row px-1 py-2">
    {foreach from=$departments item=department}
        <div class="col-md-6 {*hostpro start*}col-sm-12{*hostpro end*}">
        <div class="well">
        <div class="alert-watermark m-2">
        <i class="fa fa-envelope fa-4x"></i>
        </div>
         <h5><a href="{$smarty.server.PHP_SELF}?step=2&amp;deptid={$department.id}">{$department.name}</a></h5>
    			{if $department.description}<p>{$department.description}</p>{/if}
        </div>
        </div>
    {foreachelse}
    <div class="alert alert-info">
        {$LANG.nosupportdepartments}
    </div>
    {/foreach}
</div>
