<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="lt-ie9"> <![endif]-->
<head>
  <meta charset="UTF-8">
  <title>{$companyname} - {$pagetitle}{if $kbarticle.title} - {$kbarticle.title}{/if}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="{$WEB_ROOT}/templates/{$template}/assets/css/bootstrap-hexa.min.css" rel="stylesheet">
  <link href="{$WEB_ROOT}/templates/{$template}/assets/css/icons.min.css" rel="stylesheet">
  <link href="{$WEB_ROOT}/templates/{$template}/assets/css/owl.carousel.min.css" rel="stylesheet">
  <link href="{$WEB_ROOT}/templates/{$template}/assets/css/perfect-scrollbar.min.css" rel="stylesheet">
  {if !empty($loadMarkdownEditor)}<link href="{$BASE_PATH_CSS}/bootstrap-markdown.min.css" rel="stylesheet" />{/if}
  <link href="{$WEB_ROOT}/templates/{$template}/assets/css/style.css" rel="stylesheet">
  <link href="{$WEB_ROOT}/templates/{$template}/assets/css/footer.css" rel="stylesheet">
  {if $hexa_extras_style}<link rel='stylesheet' href="{$WEB_ROOT}/templates/{$template}/assets/css/skins/{$hexa_extras_style}" />
  {else}
  <link rel='stylesheet' href="{$WEB_ROOT}/templates/{$template}/assets/css/skins/city.min.css" />
  {/if}
  <script type="text/javascript">
  var csrfToken = '{$token}',
  markdownGuide = '{lang key="markdown.title"}',
  locale = '{if !empty($mdeLocale)}{$mdeLocale}{else}en{/if}',
  saved = '{lang key="markdown.saved"}',
  saving = '{lang key="markdown.saving"}';
  </script>
  <script src="{$BASE_PATH_JS}/jquery.min.js"></script>
  {if $templatefile == "viewticket" && !$loggedin}
  <meta name="robots" content="noindex" />
  {/if}
  {$headoutput}
  {if file_exists($style_override)}
  <link rel="stylesheet" href="{$WEB_ROOT}/templates/{$template}/overrides/style.css">
  {/if}
  {if $LANG.locale == 'ar_AR' || $LANG.locale == 'fa_IR' || $LANG.locale == 'he_IL'}
  <link href="{$WEB_ROOT}/templates/{$template}/assets/css/bootstrap-rtl.css" rel="stylesheet">
  <link href="{$WEB_ROOT}/templates/{$template}/assets/css/style-rtl.css" rel="stylesheet">
  {/if}
  {if isset($hexa_scss)}
  <style type="text/css">
  {$hexa_scss}
  </style>
  {/if}
<link rel="apple-touch-icon" href="{$WEB_ROOT}/images/touch-icons/apple-touch-icon-iphone-60x60.png">
<link rel="apple-touch-icon" sizes="60x60" href="{$WEB_ROOT}/images/touch-icons/apple-touch-icon-ipad-76x76.png">
<link rel="apple-touch-icon" sizes="114x114" href="{$WEB_ROOT}/images/touch-icons/apple-touch-icon-iphone-retina-120x120.png">
<link rel="apple-touch-icon" sizes="144x144" href="{$WEB_ROOT}/images/touch-icons/apple-touch-icon-ipad-retina-152x152.png">

{* uniweb start *}
{literal}
        <!-- Google Tag Manager -->
        <noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-MZ24SQ"
        height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
        <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
        new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
        j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
        '//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
        })(window,document,'script','dataLayer','GTM-MZ24SQ');</script>
        <!-- End Google Tag Manager -->
{/literal}
{* uniweb end *}
</head>
<body  data-phone-cc-input="{$phoneNumberInputStyle}" class="{if $LANG.locale == 'ar_AR' || $LANG.locale == 'fa_IR' || $LANG.locale == 'he_IL'}cmsbased-rtl{else}cmsbased-ltr{/if}{if $hexa_minimal == 1} minimal{/if}"{if isset($hexa_background_image)} style="background-image: url({$hexa_background_image})"{/if}>
  {include file="$template/includes/verifyemail.tpl"}
  {if $hexa_minimal == 1}
  {include file="$template_head_minimal"}
  {elseif $minimal_cart == 'on' && $filename == 'cart'}
  <div class="hexa-container hidden-xs"><a href="{$WEB_ROOT}/contact.php" class="btn btn-xs btn-default hexa-btn" data-original-title="{$LANG.contactus}"><i class="fa fa-send-o"></i></a></div>
  <div class="login-wrapper">
    <div class="container">
      <div class="row">
        <div class="col-md-4 col-md-offset-4 logo-page">
          <a href="{$WEB_ROOT}/index.php" title="{$companyname}">
            {if !isset($hexa_logo)}
            <span class="logo">
              <span aria-hidden="true" class="icon icon-map"></span> {$companyname}</span>
              {else}
              <span class="logo">
                <img {if isset($hexa_logo_width)} style="width:{$hexa_logo_width}px" {/if} src="{$hexa_logo}">
              </span>
              {/if}
            </a>
          </div>
        </div>
        {else}
        {$headeroutput}
        <nav class="navbar hx-top-header" role="navigation">
          <div class="container">
            {if !isset($hexa_logo)}
            <a class="navbar-brand" href="index.php"><span aria-hidden="true" class="icon icon-map"></span> {$companyname}</a>
            {else}
            <a href="{$WEB_ROOT}/index.php" class="navbar-brand" style="background-image: url({$hexa_logo}); {if isset($hexa_logo_width)} width:{$hexa_logo_width}px{/if}"></a>
            {/if}
            <ul class="nav navbar-nav hx-top-nav">
              <li class="nav-item visible-xs"><span class="nav-link"><span aria-hidden="true" class="icon icon-menu btn-nav-toggle-responsive"></span></span></li>
            </ul>
            {*hostpro start*}
                 <ul class="menu top-menu fl nav hidden-xs">
                      <li class=""><a href="https://hostpro.ua/hosting-linux.html">{$LANG.m_hosting}</a>
                        <ul class="sub-menu">
                          <li class=""><a href="https://hostpro.ua/hosting-linux.html">{$LANG.m_hosting_linux}</a></li>
                          <li class=""><a href="https://hostpro.ua/pro-linux-hosting.html">{$LANG.m_hosting_pro_linux}</a></li>
                          <li class=""><a href="https://hostpro.ua/hosting-windows.html">{$LANG.m_hosting_windows}</a></li>
                          <li class=""><a href="https://hostpro.ua/wordpress-hosting.html">{$LANG.m_hosting_wordpress}</a></li>
                          <li class=""><a href="https://hostpro.ua/reseller-tarify-ot-hostpro.html">{$LANG.m_hosting_reseller}</a></li>
                        </ul>
                      </li>
                      <li class=""><a href="https://hostpro.ua/linux-vps.html">VPS</a>
                        <ul class="sub-menu">
                          <li class=""><a href="https://hostpro.ua/linux-vps.html">Linux-VPS</a></li>
                          <li class=""><a href="https://hostpro.ua/windows-vps.html">Windows-VPS</a></li>
                        </ul>
                      </li>
                      <li class=""><a href="https://hostpro.ua/servers.html">{$LANG.m_servers}</a>
                        <ul class="sub-menu">
                          <li class=""><a href="https://hostpro.ua/servers.html">{$LANG.m_servers}</a></li>
                          <li class=""><a href="https://hostpro.ua/hybrid.html">{$LANG.m_hybrid}</a></li>
                          <li class=""><a href="https://hostpro.ua/half.html">{$LANG.m_half}</a></li>
                          <li class=""><a href="https://hostpro.ua/aktsionnye-servery.html">{$LANG.m_servers_promo}</a></li>
                        </ul>
                      </li>
                      <li class=""><a href="https://hostpro.ua/cloudflare.html">{$LANG.m_cloud}</a>
                        <ul class="sub-menu">
                          <li class=""><a href="https://hostpro.ua/cdn.html">CDN</a></li>
                          <li class=""><a href="https://hostpro.ua/cloudflare.html">Cloudflare</a></li>
                        </ul>
                      </li>
                      <li class=""><a href="https://hostpro.ua/pricelist.html">{$LANG.m_domains}</a>
                        <ul class="sub-menu">
                          <li class=""><a href="https://billing.hostpro.ua/cart.php?a=add&amp;domain=register">{$LANG.m_domains_register}</a></li>
                          <li class=""><a href="https://billing.hostpro.ua/cart.php?a=add&amp;domain=transfer">{$LANG.m_domains_transfer}</a></li>
                          <li class=""><a href="https://hostpro.ua/pricelist.html">{$LANG.m_domains_pricelist}</a></li>
                          <li><a href="https://hostpro.ua/aktsionnye-domeny.html">Акционные домены</a></li>
                        </ul>
                      </li>
                      <li ><a href="https://hostpro.ua/partners.html">{$LANG.m_domains_partners}</a></li>
                      <li class=""><a href="https://hostpro.ua/ssl.html">SSL</a></li>
                  </ul>
            {*hostpro end*}
            {if $loggedin}
            <ul class="nav navbar-nav hx-user-nav hidden-xs {*hostpro start*}user-nav-custom{*hostpro end*}">
              <li class="dropdown nav-item"><a href="#" data-toggle="dropdown" role="button" aria-expanded="false" class="dropdown-toggle nav-link"> <img src="https://www.gravatar.com/avatar/{$usermailhash}?s=50&d=mm" class="avatar"><span class="user-name">{$clientsdetails.firstname} {*$clientsdetails.lastname*}</span><span class="angle-down icon icon-arrow-down"></span></a>
                <div role="menu" class="dropdown-menu {*hostpro start*}dropdown-menu-custom{*hostpro end*}">
                  <a class="dropdown-item" href="{$WEB_ROOT}/clientarea.php?action=details"><span aria-hidden="true" class="icon icon-user"></span> {$LANG.editaccountdetails}</a>
                  <a class="dropdown-item" href="{$WEB_ROOT}/clientarea.php?action=changepw"><span aria-hidden="true" class="icon icon-lock"></span> {$LANG.clientareanavchangepw}</a>
                  {if $condlinks.addfunds}<a class="dropdown-item" href="{$WEB_ROOT}/clientarea.php?action=addfunds"><span aria-hidden="true" class="icon icon-plus"></span> {$LANG.addfunds1}</a>{/if}
                  {if $condlinks.updatecc}<a class="dropdown-item" href="{$WEB_ROOT}/clientarea.php?action=creditcard"><span aria-hidden="true" class="icon icon-credit-card"></span> {$LANG.navmanagecc}</a>{/if}
                  <a class="dropdown-item" href="{$WEB_ROOT}/logout.php"><span aria-hidden="true" class="icon icon-logout"></span> {$LANG.logouttitle}</a>
                </div>
              </li>
            </ul>
            <ul class="navbar-nav hx-icons-nav hidden-xs {*hostpro start*}icon-nav-custom{*hostpro end*}">
              <li class="dropdown nav-item hx-messages"><a href="#" data-toggle="dropdown" role="button" aria-expanded="false" class="nav-link dropdown-toggle"><span class="icon icon-envelope"></span></a>
                <ul class="dropdown-menu">
                  <li>
                    <div class="title">{$LANG.navemailssent}</div>
                    <div class="hx-scroller ps-messages">
                      <div class="content">
                        <ul>
                          {foreach from=$he_emaillist key=num item=he_email}
                          <li style="border: none;border-top:1px solid #ddd;background-color: #fff;"><a href="#" onclick="popupWindow('{$WEB_ROOT}/viewemail.php?id={$he_email.id}','emlmsg',960,480);return false;">
                            <div class="icon"><span aria-hidden="true" class="icon icon-envelope"></span></div>
                            <div class="content" style="border: none;background-color:#fff;"><span class="date"><span class="glyphicon glyphicon-time"></span> {$he_email.time}</span>
                              <span class="name">{$companyname}</span><span class="desc">{$he_email.subject|truncate:150:'...'}</span></div></a>
                            </li>
                              {/foreach}
                            </ul>
                          </div>
                        </div>
                        <div class="footer"> <a href="{$WEB_ROOT}/clientarea.php?action=emails">{$LANG.viewAll}</a></div>
                      </li>
                    </ul>
                  </li>
                  <li class="dropdown nav-item hx-notifications"><a href="#" data-toggle="dropdown" role="button" aria-expanded="false" class="nav-link dropdown-toggle"><span class="icon icon-bell"></span>{if $clientsstats.numoverdueinvoices>0 || $openissuescount || $ccexpiringsoon || $ccexpiringsoon }<span class="indicator"></span>{/if}</a>
                    <ul class="dropdown-menu">
                      <li>
                        <div class="title">{$LANG.notifications}</div>
                        <div class="hx-scroller">
                          <div class="content">
                            <ul>
                              {if $clientsstats.numoverdueinvoices>0 AND in_array('invoices',$contactpermissions)}
                              <li style="border: none;border-top:1px solid #ddd;background-color: #fff;">
                                <a href="{$WEB_ROOT}/clientarea.php?action=masspay&amp;all=true">
                                  <div class="icon"><span aria-hidden="true" class="icon icon-drawer"></span></div>
                                  <div class="content" style="border: none;background-color:#fff;"><span class="desc">{$LANG.youhaveoverdueinvoices|sprintf2:$clientsstats.numoverdueinvoices}</span></div>
                                </a>
                              </li>
                              {/if}
                              {if $clientsstats.incredit AND in_array('invoices',$contactpermissions)}
                              <li style="border: none;border-top:1px solid #ddd;background-color: #fff;">
                                <a href="{$WEB_ROOT}/clientarea.php?action=addfunds">
                                  <div class="icon"><span aria-hidden="true" class="icon icon-wallet"></span></div>
                                  <div class="content" style="border: none;background-color:#fff;"><span class="desc">{$LANG.availcreditbaldesc|sprintf2:$clientsstats.creditbalance}</span></div>
                                </a>
                              </li>
                              {/if}
                              {if $openissuescount}
                              <li style="border: none;border-top:1px solid #ddd;background-color: #fff;">
                                <a href="{$WEB_ROOT}/serverstatus.php?view=open">
                                  <div class="icon"><span aria-hidden="true" class="icon icon-feed"></span></div>
                                  <div class="content" style="border: none;background-color:#fff;"><span class="desc">{$openissuescount} Open Service Issues</span></div>
                                </a>
                              </li>
                              {/if}
                              {if $scheduledissuescount}
                              <li style="border: none;border-top:1px solid #ddd;background-color: #fff;">
                                <a href="{$WEB_ROOT}/serverstatus.php?view=scheduled">
                                  <div class="icon"><span aria-hidden="true" class="icon icon-feed"></span></div>
                                  <div class="content" style="border: none;background-color:#fff;"><span class="desc">{$scheduledissuescount} Scheduled Service</span></div>
                                </a>
                              </li>
                              {/if}
                              {if $ccexpiringsoon AND in_array('invoices',$contactpermissions)}
                              <li style="border: none;border-top:1px solid #ddd;background-color: #fff;">
                                <a href="{$WEB_ROOT}/clientarea.php?action=creditcard">
                                  <div class="icon"><span aria-hidden="true" class="icon icon-credit-card"></span></div>
                                  <div class="content" style="border: none;background-color:#fff;"><span class="desc">{$LANG.ccexpiringsoon}</span></div>
                                </a>
                              </li>
                              {/if}
                            </ul>
                          </div></div>
                          <div class="footer"> <a href="{$WEB_ROOT}/serverstatus.php">{$LANG.networkstatustitle}</a></div>
                        </li>
                      </ul>
                    </li>
                    <li class="nav-item hx-settings"><a href="{$WEB_ROOT}/cart.php?a=view" class="nav-link"><span aria-hidden="true" class="icon icon-basket"></span><span class="badge cart">{$cartitems}</span></a></li>
                    {if $adminMasqueradingAsClient}
                    <li class="nav-item hx-settings"><a href="{$WEB_ROOT}/logout.php?returntoadmin=1" class="nav-link" title="{$LANG.logoutandreturntoadminarea}"><span aria-hidden="true" class="icon icon-magic-wand"></span></a></li>
                    {elseif $adminLoggedIn}
                    <li class="nav-item hx-settings"><a href="{$WEB_ROOT}/logout.php?returntoadmin=1" class="nav-link" title="{$LANG.returntoadminarea}"><span aria-hidden="true" class="icon icon-magic-wand"></span></a></li>
                    {/if}
                    {if $languagechangeenabled && count($locales) > 1}
                   <li class="dropdown nav-item hx-settings"><a href="#" data-toggle="dropdown" role="button" aria-expanded="false" class="nav-link dropdown-toggle"><span class="icon icon-globe-alt"></span></a>
                      <ul class="dropdown-menu">
                        <li>
                          <div class="title">{$LANG.chooselanguage}</div>
                          <div class="hx-scroller ps-languages">
                            <div class="{*content*}">
                              <ul>
                                {foreach from=$locales item=locale}
                                {if $LANG.chooselanguage == $locale.localisedName}
                                <li class="dropdown-item" style="border: none;"><a class="active" href="{$currentpagelinkback}language={$locale.language}"  data-lang="{$locale.language}">{$locale.localisedName}</a></li>
                                {else}
                                <li class="dropdown-item" style="border: none;"><a href="{$currentpagelinkback}language={$locale.language}"  data-lang="{$locale.language}" >{$locale.localisedName}</a></li>
                                {/if}
                                {/foreach}
                              </ul>
                            </div>
                          </div>
                        </li>
                      </ul>
                    </li>
                    {/if}
                  </ul>
                  {else}
                  <ul class="nav navbar-nav hx-logout-nav hx-icons-nav hidden-xs" style="background: none;">
                    <li class="nav-item hx-settings" style="border: none;"><a href="{$WEB_ROOT}/cart.php?a=view" class="nav-link"><span aria-hidden="true" class="icon icon-basket"></span><span class="badge cart ">{$cartitems}</span></a></li>
                    <li class="nav-item hx-settings" style="border: none;"><a data-toggle="dropdown" class="dropdown-toggle nav-link" href="#" aria-expanded="true"> <span class="icon icon-globe-alt" aria-hidden="true"></span></a>
                    <ul role="menu" id="lang-links" class="dropdown-menu" style="margin-top: 5px !important;width: 150px;left: -20px;">
                       {foreach from=$locales item=locale}
                          {if $LANG.chooselanguage == $locale.localisedName}
                                  <li style="border: none;"><a class="active" href="{$currentpagelinkback}language={$locale.language}"  data-lang="{$locale.language}">{$locale.localisedName}</a></li>
                                  {else}
                                  <li style="border: none;"><a href="{$currentpagelinkback}language={$locale.language}"  data-lang="{$locale.language}" >{$locale.localisedName}</a></li>
                          {/if}
                       {/foreach}
                    </ul>
                    </li>
                    <li class="nav-item hx-settings" style="border: none;"><a href="{$WEB_ROOT}/clientarea.php" class="btn-login">{$LANG.login}</a></li>
                  </ul>
                  {/if}
                </div>
              </nav>
              <div class="site-holder container {$mini}">
                <div class="box-holder">
                  <div class="left-sidebar">
                    <div class="sidebar-holder" data-original-title="" title="">
                      {if $loggedin}
                      <ul class="nav nav-list">
                        <li class="nav-toggle"><button class="btn  btn-nav-toggle"><i class="fa
                          {if $LANG.locale == 'ar_AR' || $LANG.locale == 'fa_IR' || $LANG.locale == 'he_IL'}
                          toggle-right fa-angle-double-right
                          {else}
                          toggle-left fa-angle-double-left
                          {/if}
                          " style="color:#666;"></i> </button></li>
                          {foreach from=$hexa_menu key=num item=menuitem}
                          <li class="{$menuitem.class} {if isset($menuitem.child) } submenu {/if} {if $menuitem.active && !isset($menuitem.child)} active {/if}  ">
                            <a href="{$menuitem.url}" data-original-title="{$menuitem.name}" {if isset($menuitem.child) } class="dropdown {if $menuitem.active} active-parent {/if} "{/if}
                            {if isset($submenuitem.new_window) && $submenuitem.new_window==1 } target="_blank" {/if}  >
                            {if $menuitem.icon != ''}<{$menuitem.icon_holder_tag} aria-hidden="true" class=" {$menuitem.icon} "></{$menuitem.icon_holder_tag}>{/if}
                            <span class="hidden-minibar {$hide_labels}"> {$menuitem.name}</span> {if isset($menuitem.child) } <span class="fa arrow rotate"> </span>{/if}
                            {if $menuitem.badge}
                            <span class="badge badge-default pull-right flip">{$menuitem.badge}</span>
                            {/if}
                          </a>
                          {if isset($menuitem.child) }
                          <ul {$display}>
                            {foreach from=$menuitem.child key=subnum item=submenuitem}
                            <li class="{$submenuitem.class} {if $submenuitem.active} active {/if}">
                              <a href="{$submenuitem.url}" data-original-title="{$submenuitem.name}" {if isset($submenuitem.new_window) && $submenuitem.new_window==1 } target="_blank" {/if} >
                                {if $submenuitem.icon != ''}<{$submenuitem.icon_holder_tag} aria-hidden="true" class=" {$submenuitem.icon} "></{$submenuitem.icon_holder_tag}>{/if}
                                <span class="hidden-minibar  {$hide_labels}"> {$submenuitem.name}</span>
                                {if $submenuitem.badge}
                                <span class="badge badge-default pull-right flip">{$submenuitem.badge}</span>
                                {/if}
                              </a>
                            </li>
                            {/foreach}
                          </ul>
                          {/if}
                        </li>
                        {/foreach}
                      </ul>
                      {else}
                      <ul class="nav nav-list">
                        <li class="nav-toggle"><button class="btn  btn-nav-toggle"><i class="fa toggle-left fa-angle-double-left" style="color:#666;"></i> </button></li>
                        {foreach from=$hexa_menu key=num item=menuitem}
                        <li class="{$menuitem.class} {if isset($menuitem.child) } submenu {/if} {if $menuitem.active && !isset($menuitem.child)} active {/if}  ">
                          <a href="{$menuitem.url}" data-original-title="{$menuitem.name}" {if isset($menuitem.child) } class="dropdown {if $menuitem.active} active-parent {/if} "{/if} {if isset($submenuitem.new_window) && $submenuitem.new_window==1 } target="_blank" {/if}  >
                            {if $menuitem.icon != ''}<{$menuitem.icon_holder_tag} aria-hidden="true" class=" {$menuitem.icon} "></{$menuitem.icon_holder_tag}>{/if}
                            <span class="hidden-minibar {$hide_labels}"> {$menuitem.name}</span> {if isset($menuitem.child) } <span class="fa arrow rotate"> </span>{/if}
                          </a>
                          {if isset($menuitem.child) }
                          <ul {$display}>
                            {foreach from=$menuitem.child key=subnum item=submenuitem}
                            <li class="{$submenuitem.class} {if $submenuitem.active} active {/if}">
                              <a href="{$submenuitem.url}" data-original-title="{$submenuitem.name}" {if isset($submenuitem.new_window) && $submenuitem.new_window==1 } target="_blank" {/if} >
                                {if $submenuitem.icon != ''}<{$submenuitem.icon_holder_tag} aria-hidden="true" class=" {$submenuitem.icon} "></{$submenuitem.icon_holder_tag}>{/if}
                                <span class="hidden-minibar  {$hide_labels}"> {$submenuitem.name}</span>
                              </a>
                            </li>
                            {/foreach}
                          </ul>
                          {/if}
                        </li>
                        {/foreach}
                      </ul>
                      {/if}
                    </div>
                  </div>
                  <div class="content main-content onload">
                    <div class="row">
                      <div class="col-md-12">
                        {/if}
                        <div id="cmsbased_alerts_holder"></div>
