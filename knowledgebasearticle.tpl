{include file="$template/pageheader.tpl" title=$LANG.knowledgebasetitle icon=notebook}
<p class="ml-2 mt-1"><small>{$breadcrumbnav}</small></p>
<div class="row">
<div class="col-md-12">
<h3>{$kbarticle.title}</h3>
{if $kbarticle.tags }
<p><i class="fa fa-tag"></i> {$kbarticle.tags}</p>
{/if}
<p>{$kbarticle.text}</p>
</div>
</div>
<hr>
<div class="row ">
<div class="col-md-12">
<div class="hidden-print form-group">
{if $kbarticle.voted}{$LANG.knowledgebaserating}{/if}
{if $kbarticle.voted}
{$kbarticle.useful} {$LANG.knowledgebaseratingtext} ({$kbarticle.votes} {$LANG.knowledgebasevotes})
			{else}
                <form action="{routePath('knowledgebase-article-view', {$kbarticle.id}, {$kbarticle.urlfriendlytitle})}" method="post">
                    <input type="hidden" name="useful" value="vote">
                    <div class="btn-group pull-left" role="group">
                    <button type="submit" name="vote" value="yes" class="btn btn-success" title="{$LANG.knowledgebasehelpful} - {$LANG.knowledgebaseyes}">&nbsp;&nbsp;<i class="fa fa-thumbs-o-up"></i>&nbsp;&nbsp;</button>
                    <button type="submit" name="vote" value="no" class="btn btn-danger" title="{$LANG.knowledgebasehelpful} - {$LANG.knowledgebaseno}"><i class="fa fa-thumbs-o-down"></i></button>
                    </div>
                </form>
            {/if}
    <span class="pull-right"><a href="#" class="btn btn-link" onclick="window.print();return false"><i class="fa fa-print">&nbsp;</i>{$LANG.knowledgebaseprint}</a></span>
</div>
</div>
</div>

{if $kbarticles}
{include file="$template/subheader.tpl" title=$LANG.knowledgebasealsoread icon=paper-clip}

<div class="list-group">
	{foreach key=num item=kbarticle from=$kbarticles}
<a class="list-group-item" href="{routePath('knowledgebase-article-view', {$kbarticle.id}, {$kbarticle.urlfriendlytitle})}">{$kbarticle.title} <span class="badge">{$kbarticle.views}</span></a>
	{/foreach}
</div>
{/if}
