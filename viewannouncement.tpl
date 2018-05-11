<div class="well" style="px-1 py-2">
<h1 class="h3">{$title}</h1>
<p><span class="glyphicon glyphicon-calendar" aria-hidden="true"></span> {$timestamp|date_format:"%A, %B %e, %Y"}</p>
<p>{$text}</p>
<a href="{routePath('announcement-index')}" class="btn btn-outline">{$LANG.clientareabacklink}</a>
</div>

<div class="row px-1">
  <div class="col-md-12">
  <div class="pull-right">
{if $twittertweet}
<div style="float:left;margin-right:7px;">
        <a href="https://twitter.com/share" class="twitter-share-button" data-count="vertical" data-via="{$twitterusername}">Tweet</a><script type="text/javascript" src="//platform.twitter.com/widgets.js"></script>
</div>
{/if}

{if $googleplus1}
{literal}
<script src="https://apis.google.com/js/platform.js" async defer></script>
<div style="float:left;margin-right:7px;">
<div class="g-plusone" data-size="medium" data-annotation="none"></div>
</div>
{/literal}
{/if}

{if $facebookrecommend}
{literal}
<div style="float:left;">
<div id="fb-root"></div>
    <script>(function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) {return;}
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
        fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));</script>
    {/literal}
    <div class="fb-like" data-href="{fqdnRoutePath('announcement-view', $id, $urlfriendlytitle)}" data-layout="button_count" data-action="like" data-size="small" data-show-faces="true" data-share="true"></div>
</div>
{/if}
</div>
</div>
</div>


{if $facebookcomments}
    {literal}
    <div id="fb-root">
    </div>
    <script>(function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) {return;}
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
        fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));</script>
    {/literal}
    <fb:comments href="{fqdnRoutePath('announcement-view', $id, $urlfriendlytitle)}" num_posts="5" data-width="100%"></fb:comments>
{/if}
