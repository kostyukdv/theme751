{if $announcementsFbRecommend}
    <script>
        (function(d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) {
                return;
            }
            js = d.createElement(s); js.id = id;
            js.src = "//connect.facebook.net/{$LANG.locale}/all.js#xfbml=1";
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));
    </script>
{/if}
{include file="$template/pageheader.tpl" title=$LANG.announcementstitle desc=$LANG.announcementsdescription icon=feed}
<div class="announce-items-wrap announce-standard">
    <div class="timeline"></div>
    <ul class="announce-items list-unstyled row standard-items clearfix">
{foreach from=$announcements item=announcement}
            <li class="announce-item col-sm-12">
              <span class="standard-post-date"><span class="glyphicon glyphicon-calendar" aria-hidden="true"></span> {"M jS, Y"|date:$announcement.timestamp}</span>

            {if $announcement.editLink}
                <a href="{$announcement.editLink}" class="admin-inline-edit">
                    <i class="fa fa-pencil fa-fw"></i>
                    {$LANG.edit}
                </a>
            {/if}

                <div class="standard-post-content no-thumb clearfix">
                    <h1 class="h3"><a href="{routePath('announcement-view', $announcement.id, $announcement.urlfriendlytitle)}">{$announcement.title}</a></h1>
                    <div class="excerpt">
                        <p>{if $announcement.text|strip_tags|strlen < 360}{$announcement.text}{else}{$announcement.summary}{/if}</p>
                    </div>
                   <a href="{routePath('announcement-view', $announcement.id, $announcement.urlfriendlytitle)}" class="btn btn-outline btn-lg text-uppercase">{$LANG.readmore}</a>
                    <div class="comments-likes">
                      {if $announcementsFbRecommend}
                          <div class="fb-like" data-layout="button_count" data-href="{fqdnRoutePath('announcement-view', $announcement.id, $announcement.urlfriendlytitle)}" data-send="true"></div>
                      {/if}
                    </div>
                </div>
            </li>
{foreachelse}
<li class="announce-item col-sm-12"><div class="well">{$LANG.noannouncements}</div></li>
{/foreach}
</ul>

    </div>
{if $prevpage || $nextpage}

<nav class="text-center" aria-label="Page Navigation">
  <ul class="pagination pagination-sm">
 {if $prevpage}
    <li>
      <a href="{routePath('announcement-index-paged', $prevpage, $view)}" aria-label="{$LANG.previouspage}">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
{/if}
    <li class="disabled"><a href="#">{$LANG.page} {$pagenumber}</a></li>

    {if $nextpage}
    <li>
      <a href="{routePath('announcement-index-paged', $nextpage, $view)}" aria-label="{$LANG.nextpage}">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
   {/if}
  </ul>
</nav>
{/if}
