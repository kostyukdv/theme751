{include file="$template/pageheader.tpl" title=$LANG.knowledgebasetitle icon=notebook}
<form role="form" method="post" action="{routePath('knowledgebase-search')}">
  <div class="input-group kb-search p-1 {*hostpro start*}st-input{*hostpro end*}">
    <input type="text" id="inputKnowledgebaseSearch" name="search" class="{*hostpro start*}st-input-knb{*hostpro end*}{*form-control*}" placeholder="{*hostpro start*}Поиск по базе{*hostpro end*}{*What can we help you with?*}" />
    <span class="input-group-btn">
      <button type="submit" class="{*hostpro start*}knowledgebase-butt{*hostpro end*}{*btn btn-primary*}">Поиск{*<i class="fa fa-search"></i>*}</button>
    </span>
  </div>
</form>
{include file="$template/subheader.tpl" title=$LANG.knowledgebasecategories}
{if $kbcats}
<div class="row px-1">
  {foreach from=$kbcats name=kbcats item=kbcat}
  <div class="col-md-4">
    <h4><a {*hostpro start*}class="knowledgebase-category-link"{*hostpro end*}  href="{routePath('knowledgebase-category-view', {$kbcat.id}, {$kbcat.urlfriendlyname})}">
      {*<span class="glyphicon glyphicon-folder-close"></span>*}
      {*hostpro start*}<i class="fa fa-folder-o" aria-hidden="true"></i>{*hostpro end*}
      {$kbcat.name} {*<span class="badge">*}({$kbcat.numarticles}){*</span>*}
    </a></h4>
    <p>{$kbcat.description}</p>
  </div>
  {if $smarty.foreach.kbcats.iteration mod 3 == 0}
</div><div class="row px-1">
  {/if}
  {/foreach}
</div>
{else}
{include file="$template/includes/alert.tpl" type="info" msg=$LANG.knowledgebasenoarticles textcenter=true}
{/if}

{if $kbmostviews}

{include file="$template/subheader.tpl" title=$LANG.knowledgebasepopular}
{foreach from=$kbmostviews name=kbmostviews item=kbarticle}
{if $smarty.foreach.kbmostviews.iteration is odd}
<div class="row {*row-eq-height*} px-1">
  {/if}
    <div class="{*hostpro start*}col-md-12{*hostpro end*}{*col-md-6*}">
      <div class="{*hostpro start*}knowledgebase-article-wrap{*hostpro end*}{*well well-sm*}">
        <h5><a {*hostpro start*}class="knowledgebase-article-link"{*hostpro end*} href="{routePath('knowledgebase-article-view', {$kbarticle.id}, {$kbarticle.urlfriendlytitle})}">
          {*<span class="glyphicon glyphicon-file"></span>*}<i class="fa fa-file-text-o"></i>&nbsp;{$kbarticle.title}
        </a></h5>
        <p>{$kbarticle.article|truncate:240:"..."}</p>
      </div>
    </div>
{if $smarty.foreach.kbmostviews.iteration mod 2 == 0 ||  $smarty.foreach.kbmostviews.last}
</div>
{/if}
{/foreach}
{/if}
