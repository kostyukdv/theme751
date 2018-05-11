</div><!--/.content-->
</div>
{if $hexa_minimal == 0}
</div>
</div>
</div>
<div class="container sub-footer">
<div class="row">
<div class="col-md-12">
<nav class="std-menu pull-right flip visible-xs"  style="margin-right:-15px;">
  <ul class="menu">
  <li class="menu-item">{*hostpro start*}<span aria-hidden="true" class=" icon icon-home footer-icon"></span>{*hostpro end*}<a href="{$WEB_ROOT}/clientarea.php">{$LANG.dashboard}</a></li>
  <li class="menu-item">{*hostpro start*}<span aria-hidden="true" class="icon icon-basket footer-icon"></span>{*hostpro end*}<a href="{$WEB_ROOT}/cart.php">{$LANG.newordertitle}</a></li>
  {if $condlinks.affiliates}<li class="menu-item">{*hostpro start*}<span aria-hidden="true" class=" icon icon-diamond footer-icon"></span>{*hostpro end*}<a href="{$WEB_ROOT}/affiliates.php">{$LANG.affiliatestitle}</a></li>{/if}
  <li class="menu-item">{*hostpro start*}<span aria-hidden="true" class="icon icon-support footer-icon"></span>{*hostpro end*}<a href="{$WEB_ROOT}/submitticket.php">{$LANG.opennewticket}</a></li>
  <li class="menu-item">{*hostpro start*}<span aria-hidden="true" class=" icon icon-envelope footer-icon"></span>{*hostpro end*}<a href="{$WEB_ROOT}/contact.php">{$LANG.contactus}</a></li>
  </ul>
</nav>
</div>
</div>
</div>
{/if}
{*hostpro start*}
<div class="mainfoot">
    <div class="float-foot stopped">
        <div class="wrap cf">
            <div class="ff-phone">

                <span class="txt"><img src="templates/{$template}/images/cell.png" style="left: 0; margin-right: 5px; margin-bottom: 3px;">{$LANG.m_support2}</span>
                <dl class="de-select de-select-phones">
                    <dt class="">(044) 585-77-96</dt>
                    <dd>
                        <a class="current" href="#">(044) 585-77-96</a>
                       <!-- <a href="#">(093) 585-77-96</a>
                        <a href="#">(050) 585-77-96</a>
                        <a href="#">(050) 585-77-96</a> -->
                    </dd>
                </dl>

            </div>
            <div class="ff-mail">
                <a href="mailto:support@hostpro.ua">support@hostpro.ua</a>
            </div>
            <div class="ff-chat">

            </div>
        </div>
    </div>
        <div class="wrap">

                <div class="f-info">
            <div class="foot-item">
                <a class="foot-logo" href="https://hostpro.ua"><img src="templates/{$template}/img/foot-logo.png" alt=""></a>
                <p class="copy">
                    © HostPro  {$LANG.m_ua} {'Y'|date}<br>
                    {$LANG.m_copy}
                </p>
                <p class="deco">
                    <a target="_blank" href="http://deco.agency"></a>
                </p>
            </div>
                        <div class="foot-item foot-item-menu">
                                <h3>HostPro <i class="icon-foot-spoil"></i></h3>
                                <ul class="">
                                  <li id="menu-item-67" class=""><a href="https://hostpro.ua/about.html">{$LANG.m_about}</a></li>
                                  <li id="menu-item-66" class=""><a href="https://hostpro.ua/documents.html">{$LANG.m_documents}</a></li>
                                  <li id="menu-item-68" class=""><a href="https://hostpro.ua/oplata.html">{$LANG.m_oplata}</a></li>
                                  <li id="menu-item-69" class=""><a href="https://hostpro.ua/partners.html">{$LANG.m_partner_program}</a></li>
                                  <li id="menu-item-70" class=""><a href="https://hostpro.ua/contacts.html">{$LANG.m_contacts}</a></li>
                                  <li id="menu-item-70" class=""><a href="https://hostpro.ua/tos.html">Privacy Policy</a></li>
</ul>                   </div>
                        <div class="foot-item foot-item-menu">
                                <h3>{$LANG.m_services}<i class="icon-foot-spoil"></i></h3>
                                <ul class="">
                                  <li id="menu-item-409" class=""><a href="https://hostpro.ua/hosting-linux.html">{$LANG.m_hosting}</a></li>
                                  <li id="menu-item-486" class=""><a href="https://hostpro.ua/linux-vps.html">VPS</a></li>
                                  <li id="menu-item-515" class=""><a href="https://hostpro.ua/servers.html">{$LANG.m_servers}</a></li>
                                  <li id="menu-item-480" class=""><a href="https://hostpro.ua/cloudflare.html">{$LANG.m_cloud}</a></li>
                                  <li id="menu-item-64" class=""><a href="https://hostpro.ua/cdn.html">CDN</a></li>
                                  <li id="menu-item-621" class=""><a href="https://hostpro.ua/pricelist.html">{$LANG.m_domains}</a></li>
                                  <li id="menu-item-621" class=""><a href="https://hostpro.ua/ssl.html">SSL</a></li>
</ul>                   </div>
                        <div class="foot-item foot-item-menu">
                                <h3>{$LANG.m_support2}<i class="icon-foot-spoil"></i></h3>
                                <ul class="">
                                                  <li id="menu-item-628" class=""><a href="http://blog.hostpro.ua">{$LANG.m_blog}</a></li>
                                  <li id="menu-item-452" class=""><a href="http://dnsstuff.hostpro.ua">{$LANG.m_dns}</a></li>
                                  <li id="menu-item-453" class=""><a href="{*hostpro start*}https://billing.hostpro.ua/submitticket.php{*hostpro end*}">{$LANG.m_support}</a></li>
                                  <li id="menu-item-607" class=""><a href="{*hostpro start*}https://billing.hostpro.ua/knowledgebase.php{*hostpro end*}">{$LANG.m_kb}</a></li>
</ul>

                <div class="foot-socials foot-socials-new">
                                                        <a class="fs-item fs-fb" href="https://www.facebook.com/HostPro.ua"></a>
                                                        <a class="fs-item fs-tw" href="https://twitter.com/hostproua"></a>
                                                        {*<a class="fs-item fs-vk" href="https://vk.com/hostproua"></a>*}
                                                </div>
                        </div>
</div>
</div>
</div>
{*hostpro end*}
<script src='{$WEB_ROOT}/templates/{$template}/assets/js/bootstrap.min.js'></script>
<script src='{$WEB_ROOT}/templates/{$template}/assets/js/bootstrap-multiselect.min.js'></script>
<script src='{$WEB_ROOT}/templates/{$template}/assets/js/bootstrap-confirmation.min.js'></script>
{if !empty($loadMarkdownEditor)}
    <script src="{$WEB_ROOT}/templates/{$template}/assets/js/bootstrap-markdown.js"></script>
{/if}
<script src='{$WEB_ROOT}/templates/{$template}/assets/js/jquery.easypiechart.min.js'></script>
<script src='{$WEB_ROOT}/templates/{$template}/assets/js/owl.carousel.min.js'></script>
<script src='{$WEB_ROOT}/templates/{$template}/assets/js/perfect-scrollbar.jquery.min.js'></script>
<script src='{$WEB_ROOT}/templates/{$template}/assets/js/waves.min.js'></script>
<script src='{$WEB_ROOT}/templates/{$template}/assets/js/intlTelInput.min.js'></script>
<script src='{$WEB_ROOT}/templates/{$template}/assets/js/utils.js'></script>
<script src='{$WEB_ROOT}/templates/{$template}/assets/js/cookie.js'></script>
<script src='{$WEB_ROOT}/templates/{$template}/assets/js/whmcs.js'></script>
<script src="{$BASE_PATH_JS}/AjaxModal.js"></script>

<div class="modal system-modal fade" id="modalAjax" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content panel panel-primary">
            <div class="modal-header panel-heading">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                    <span class="sr-only">Close</span>
                </button>
                <h4 class="modal-title">Title</h4>
            </div>
            <div class="modal-body panel-body">
                Loading...
            </div>
            <div class="modal-footer panel-footer">
                <div class="pull-left loader">
                    <i class="fa fa-circle-o-notch fa-spin"></i> Loading...
                </div>
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    Close
                </button>
                <button type="button" class="btn btn-primary modal-submit">
                    Submit
                </button>
            </div>
        </div>
    </div>
</div>
{*hostpro start*}
{$footeroutput}
{if $langchange}{$setlanguage}{/if}
<script type="text/javascript">
    var csrfToken = '{$token}';
</script>

{literal}
<script type="text/javascript">
/* <![CDATA[ */
var google_conversion_id = 1005826420;
var google_custom_params = window.google_tag_params;
var google_remarketing_only = true;
/* ]]> */
</script>
<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">
</script>
<noscript>
<div style="display:inline;">
<img height="1" width="1" style="border-style:none;" alt="" src="//googleads.g.doubleclick.net/pagead/viewthroughconversion/1005826420/?value=0&amp;guid=ON&amp;script=0"/>
</div>
</noscript>
{/literal}
{*hostpro end*}
</body>
</html>
