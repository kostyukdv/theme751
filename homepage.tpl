{include file="$template/pageheader.tpl" title=$LANG.doToday icon=calendar}
   <div class="row px-1 pt-1">
   {if $registerdomainenabled || $transferdomainenabled}
     <div class="col-md-4">
      <a title="{$LANG.navservices}" href="domainchecker.php">
       <div class="info-box  bg-info  text-white" id="initial-tour">
        <div class="info-icon bg-info-dark">
         <span aria-hidden="true" class="icon icon-globe"></span>
       </div>
       <div class="info-details">
         <h4>{$LANG.buyadomain}</h4>
         <p>{$LANG.ordernowbutton}</p>
       </div>
     </div>
   </a>
 </div>
 {/if}
 <div class="col-md-4">
  <a title="{$LANG.cartproductdomain}" href="cart.php">
   <div class="info-box  bg-info  text-white">
    <div class="info-icon bg-info-dark">
     <span aria-hidden="true" class="icon icon-layers"></span>
   </div>
   <div class="info-details">
     <h4>{$LANG.orderhosting}</h4>
     <p>{$LANG.ordernowbutton}</p>
   </div>
 </div>
</a>
</div>
<div class="col-md-4">
<a title="{$clientsstats.numdueinvoices}" href="submitticket.php">
  <div class="info-box  bg-info  text-white">
   <div class="info-icon bg-warn-dark">
    <span aria-hidden="true" class="icon icon-support"></span>
  </div>
  <div class="info-details">
    <h4>{$LANG.getsupport}</h4>
    <p>{$LANG.supportticketssubmitticket}</p>
  </div>
</div>
</a>
</div>
</div>
{if $announcements}
<div class="panel panel-default panel-news">
  <div class="panel-heading text-uppercase">{$LANG.ourlatestnews}
    <div class="pull-right flip">
    <a class="prev pull-left"><span class="glyphicon glyphicon-chevron-left"></span></a> <a class="next"><span class="glyphicon glyphicon-chevron-right"></span></a></div>
  </div>
  <div class="panel-body">
   <div id="owl-news" class="owl-carousel pb-1">
    <div class="item px-1"><i class="fa fa-clock-o pull-left flip" aria-hidden="true"></i> <a class="date pull-left flip pr-1" href="announcements.php?id={$announcements.0.id}">{$announcements.0.date}</a> {$announcements.0.text|strip_tags|truncate:500:'...'}</div>
    {if $announcements.1.text}
    <div class="item px-1"><i class="fa fa-clock-o pull-left flip" aria-hidden="true"></i><a class="date pull-left flip pr-1" href="announcements.php?id={$announcements.1.id}">{$announcements.1.date}</a> {$announcements.1.text|strip_tags|truncate:500:'...'}</div>
    {/if}
    {if $announcements.2.text}
    <div class="item px-1"><i class="fa fa-clock-o pull-left flip" aria-hidden="true"></i><a class="date pull-left flip pr-1" href="announcements.php?id={$announcements.2.id}">{$announcements.2.date}</a> {$announcements.2.text|strip_tags|truncate:500:'...'}</div>
    {/if}
  </div>
</div>
</div>
{literal}<script>$(document).ready(function() {
  var owl = $("#owl-news");owl.owlCarousel({
      autoHeight : true, loop:true, items:1{/literal}
      {if $LANG.locale == 'ar_AR' || $LANG.locale == 'fa_IR' || $LANG.locale == 'he_IL'} ,rtl:true {/if}{literal}
    });
$('.next').click(function() {
    owl.trigger('next.owl.carousel');
})
$('.prev').click(function() {
    owl.trigger('prev.owl.carousel', [300]);
})

});</script>{/literal}
{/if}
{if $ccexpiringsoon}
<div class="alert alert-danger">
 <p><strong>{$LANG.ccexpiringsoon}:</strong> {$LANG.ccexpiringsoondesc|sprintf2:'
  <a href="clientarea.php?action=creditcard" class="btn btn-danger btn-xs pull-right flip">':'</a>'}</p>
</div>
{/if}


<section id="home-banner">
        {if $registerdomainenabled || $transferdomainenabled}
      <div class="col-md-12">
            <p>{$LANG.orderForm.findNewDomain}</p>
            <div class="domain-checker-container">
                <div class="domain-checker-bg clearfix">
                    <form method="post" action="domainchecker.php" id="frmDomainChecker">
                        <input type="hidden" name="a" value="checkDomain">
                        <div class="row">
                            <div class="col-md-12">
                              <div class="form-group">
                                <div class="input-group input-group-lg input-group-box st-input">
                                    <input type="text" name="domain" class="form-control" placeholder="{$LANG.findyourdomain}" value="{$lookupTerm}" id="inputDomain" data-toggle="tooltip" data-placement="left" data-trigger="manual" title="{lang key='orderForm.domainOrKeyword'}" />
                                    <span class="input-group-btn">
                                        <button type="submit" id="btnCheckAvailability" class="{*btn btn-primary domain-check-availability*}btn-order-4 orange">{$LANG.search}</button>
                                    </span>
                                </div>
                                <p class="help-block">
                                <a href="cart.php?a=add&domain=transfer" class="btn {*btn-sm*} btn-link"><i class="fa fa-fw fa-truck" aria-hidden="true"></i> {lang key='orderForm.transferDomain'}</a>
                                <a href="cart.php" class="btn {*btn-sm*} btn-link"><i class="fa fa-fw fa-plus" aria-hidden="true"></i> {lang key='orderForm.addHosting'}</a>
                                </p>
                            </div>
                          </div>
                        </div>
                        {if $captcha}
                            <div class="captcha-container" id="captchaContainer">
                                {if $captcha == "recaptcha"}
                                    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
                                    <div id="google-recaptcha" class="g-recaptcha center-block" data-sitekey="{$reCaptchaPublicKey}" data-toggle="tooltip" data-placement="left" data-trigger="manual" title="{lang key='orderForm.required'}" ></div>
                                {else}
                                        <div class="col-md-4">
                                            <p>{lang key="cartSimpleCaptcha"}</p>
                                            <div class="form-group">
                                            <img id="inputCaptchaImage" src="includes/verifyimage.php" align="middle" /></div>
                                              <div class="form-group">
                                            <input id="inputCaptcha" type="text" name="code" maxlength="5" class="form-control input-lg" data-toggle="tooltip" data-placement="right" data-trigger="manual" title="{lang key='orderForm.required'}" />
                                        </div>
                                    </div>
                                  </div>
                                {/if}
                            </div>
                        {/if}
                    </form>
                </div>
            </div>
        {/if}
    
</section>
