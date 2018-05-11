{include file="$template/pageheader.tpl" title=$LANG.knowledgebasetitle icon=notebook}
<p class="px-1"><small>{$breadcrumbnav}</small></p>
  <form role="form" method="post" action="{routePath('knowledgebase-search')}">
      <div class="input-group kb-search p-1">
          <input type="text"  id="inputKnowledgebaseSearch" name="search" class="form-control" placeholder="What can we help you with?" value="{$searchterm}" />
          <span class="input-group-btn">
              <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i></button>
          </span>
      </div>
  </form>

  {if $kbcats}
      {include file="$template/subheader.tpl" title=$LANG.knowledgebasecategories}

      <div class="row px-1 kbcategories">
          {foreach name=kbasecats from=$kbcats item=kbcat}
              <div class="col-md-4">
                  <a href="{routePath('knowledgebase-category-view',{$kbcat.id},{$kbcat.urlfriendlyname})}">
                      <span class="glyphicon glyphicon-folder-close"></span> {$kbcat.name} <span class="badge badge-info">{$kbcat.numarticles}</span>
                  </a>
                  <p>{$kbcat.description}</p>
              </div>
          {/foreach}
      </div>
  {/if}

  {if $kbarticles || !$kbcats}
      {if $tag}
          <h2>{$LANG.kbviewingarticlestagged} '{$tag}'</h2>
      {else}
          {include file="$template/subheader.tpl" title=$LANG.knowledgebasearticles}
      {/if}


          {foreach from=$kbarticles name=kbarticles item=kbarticle}
          {if $smarty.foreach.kbarticles.iteration is odd}
          <div class="row px-1 row-eq-height">
            {/if}
          <div class="col-md-6">
          <div class="well well-sm">
              <h4><a href="{routePath('knowledgebase-article-view', {$kbarticle.id}, {$kbarticle.urlfriendlytitle})}">
                  <span class="glyphicon glyphicon-file"></span>&nbsp;{$kbarticle.title}
              </a></h4>
              <p>{$kbarticle.article|truncate:200:"..."}</p>
            </div>
          </div>
            {if $smarty.foreach.kbarticles.iteration mod 2 == 0 ||  $smarty.foreach.kbarticles.last}
            </div>
            {/if}
          {foreachelse}
              {include file="$template/includes/alert.tpl" type="warning" msg=$LANG.knowledgebasenoarticles textcenter=true}
          {/foreach}
  {/if}
