{if file_exists($footer_override)}
  {include file="$template/overrides/footer.tpl"}
{else}
</div><!--/.content-->
</div>
{if $hexa_minimal == 0}
</div>
</div>
</div>
<div class="container sub-footer">
<div class="row">
<div class="col-md-12">
<nav class="std-menu pull-right flip"  style="margin-right:-15px;">
  <ul class="menu">
  <li class="menu-item"><a href="{$WEB_ROOT}/clientarea.php">{$LANG.dashboard}</a></li>
  <li class="menu-item"><a href="{$WEB_ROOT}/cart.php">{$LANG.ordertitle}</a></li>
  {if $condlinks.affiliates}<li class="menu-item"><a href="{$WEB_ROOT}/affiliates.php">{$LANG.affiliatestitle}</a></li>{/if}
  <li class="menu-item"><a href="{$WEB_ROOT}/submitticket.php">{$LANG.opennewticket}</a></li>
  <li class="menu-item"><a href="{$WEB_ROOT}/contact.php">{$LANG.contactus}</a></li>
  </ul>
</nav>
</div>
</div>
</div>
{/if}
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

{$footeroutput}
{if $languagechangeenabled && count($locales) > 1}
{if $langchange}{$setlanguage}{/if}
{/if}
</body>
</html>
{/if}
