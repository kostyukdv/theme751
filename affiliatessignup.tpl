{if $affiliatesystemenabled}
{include file="$template/pageheader.tpl" title=$LANG.affiliatesactivate desc=$LANG.affiliatesignupintro icon=diamond}
<div class="row py-2">
<div class="col-md-6 col-md-offset-3">
<ul class="list-group">
  <li class="list-group-item">{$LANG.affiliatesignupinfo1}</li>
  <li class="list-group-item">{$LANG.affiliatesignupinfo2}</li>
  <li class="list-group-item">{$LANG.affiliatesignupinfo3}</li>
</ul>
<div class="form-group">
<form method="post" action="affiliates.php">
<input type="hidden" name="activate" value="true" />
<input type="submit" value="{$LANG.affiliatesactivate}" class="btn btn-default btn-block" />
</form>
</div>
</div>
</div>

{else}
   <div class="row">
      <div class="col-md-12">
        <h3 class="page-header"><span aria-hidden="true" class="icon icon-users"></span> {$LANG.affiliatestitle} </h3>
      </div>
    </div>
<div class="alert alert-warning">
<p>{$LANG.affiliatesdisabled}</p>
</div>
{/if}
