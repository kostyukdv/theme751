/**
 * WHMCS core JS library reference
 *
 * @copyright Copyright (c) WHMCS Limited 2005-2017
 * @license http://www.whmcs.com/license/ WHMCS Eula
 */

(function (window, factory) {
    if (typeof window.WHMCS !== 'object') {
        window.WHMCS = factory;
    }
}(
    window,
    {
        hasModule: function (name) {
            return (typeof WHMCS[name] !== 'undefined'
                && Object.getOwnPropertyNames(WHMCS[name]).length > 0);
        },
        loadModule: function (name, module) {
            if (this.hasModule(name)) {
                return;
            }

            WHMCS[name] = {};
            if (typeof module === 'function') {
                (module).apply(WHMCS[name]);
            } else {
                for (var key in module) {
                    if (module.hasOwnProperty(key)) {
                        WHMCS[name][key] = {};
                        (module[key]).apply(WHMCS[name][key]);
                    }
                }
            }
        }
    }
));

/**
 * WHMCS authentication module
 *
 * @copyright Copyright (c) WHMCS Limited 2005-2017
 * @license http://www.whmcs.com/license/ WHMCS Eula
 */

(function(module) {
    if (!WHMCS.hasModule('authn')) {
        WHMCS.loadModule('authn', module);
    }
})({
provider: function () {
    var callbackFired = false;

    /**
     * @return {jQuery}
     */
    this.feedbackContainer = function () {
        return jQuery(".providerLinkingFeedback");
    };

    /**
     * @returns {jQuery}
     */
    this.btnContainer = function () {
        return jQuery(".providerPreLinking");
    };

    this.feedbackMessage = function (context) {
        if (typeof context === 'undefined') {
            context = 'complete_sign_in';
        }
        var msgContainer = jQuery('p.providerLinkingMsg-preLink-' + context);
        if (msgContainer.length) {
            return msgContainer.first().html();
        }

        return '';
    };

    this.showProgressMessage = function(callback) {
        this.feedbackContainer().fadeIn('fast', function () {
            if (typeof callback === 'function' && !callbackFired) {
                callbackFired = true;
                callback();
            }
        });
    };

    this.preLinkInit = function (callback) {
        var icon = '<i class="fa fa-fw fa-spinner fa-spin"></i> ';

        this.feedbackContainer()
            .removeClass('alert-danger alert-success')
            .addClass('alert alert-info')
            .html(icon + this.feedbackMessage())
            .hide();

        var btnContainer = this.btnContainer();
        if (btnContainer.length) {
            if (btnContainer.data('hideOnPrelink')) {
                var self = this;
                btnContainer.fadeOut('false', function ()
                {
                    self.showProgressMessage(callback)
                });
            } else if (btnContainer.data('disableOnPrelink')) {
                btnContainer.find('.btn').addClass('disabled');
                this.showProgressMessage(callback);
            } else {
                this.showProgressMessage(callback);
            }
        } else {
            this.showProgressMessage(callback);
        }
    };

    this.displayError = function (provider, errorCondition, providerErrorText){
        jQuery('#providerLinkingMessages .provider-name').html(provider);

        var feedbackMsg = this.feedbackMessage('connect_error');
        if (errorCondition) {
            var errorMsg = this.feedbackMessage(errorCondition);
            if (errorMsg) {
                feedbackMsg = errorMsg
            }
        }

        if (providerErrorText && $('.btn-logged-in-admin').length > 0) {
            feedbackMsg += ' Error: ' + providerErrorText;
        }

        this.feedbackContainer().removeClass('alert-info alert-success')
            .addClass('alert alert-danger')
            .html(feedbackMsg).slideDown();
    };

    this.displaySuccess = function (data, context, provider) {
        var icon = provider.icon;
        var htmlTarget = context.htmlTarget;
        var targetLogin = context.targetLogin;
        var targetRegister = context.targetRegister;
        var displayName = provider.name;
        var feedbackMsg = '';

        switch (data.result) {
            case "logged_in":
            case "2fa_needed":
                feedbackMsg = this.feedbackMessage('2fa_needed');
                this.feedbackContainer().removeClass('alert-danger alert-warning alert-success')
                    .addClass('alert alert-info')
                    .html(feedbackMsg);
                window.location = data.redirect_url ? data.redirect_url : context.redirectUrl;
                break;

            case "linking_complete":
                var accountInfo = '';
                if (data.remote_account.email) {
                    accountInfo = data.remote_account.email;
                } else {
                    accountInfo = data.remote_account.firstname + " " + data.remote_account.lastname;
                }

                accountInfo = accountInfo.trim();

                feedbackMsg = this.feedbackMessage('linking_complete').trim().replace(':displayName', displayName);
                if (accountInfo) {
                    feedbackMsg = feedbackMsg.replace(/\.$/, ' (' + accountInfo + ').');
                }

                this.feedbackContainer().removeClass('alert-danger alert-warning alert-info')
                    .addClass('alert alert-success')
                    .html(icon + feedbackMsg);
                break;

            case "login_to_link":
                if (htmlTarget === targetLogin) {
                    feedbackMsg = this.feedbackMessage('login_to_link-signin-required');
                    this.feedbackContainer().removeClass('alert-danger alert-success alert-info')
                        .addClass('alert alert-warning')
                        .html(icon + feedbackMsg);
                } else {
                    var emailField = jQuery("input[name=email]");
                    var firstNameField = jQuery("input[name=firstname]");
                    var lastNameField = jQuery("input[name=lastname]");

                    if (emailField.val() === "") {
                        emailField.val(data.remote_account.email);
                    }

                    if (firstNameField.val() === "") {
                        firstNameField.val(data.remote_account.firstname);
                    }

                    if (lastNameField.val() === "") {
                        lastNameField.val(data.remote_account.lastname);
                    }

                    if (htmlTarget === targetRegister) {
                        if (typeof WHMCS.client.registration === 'object') {
                            WHMCS.client.registration.prefillPassword();
                        }
                        feedbackMsg = this.feedbackMessage('login_to_link-registration-required');
                        this.feedbackContainer().fadeOut('slow', function () {
                            $(this).removeClass('alert-danger alert-success alert-info')
                                .addClass('alert alert-warning')
                                .html(icon + feedbackMsg).fadeIn('fast');
                        });

                    } else {
                        // this is checkout
                        if (typeof WHMCS.client.registration === 'object') {
                            WHMCS.client.registration.prefillPassword();
                        }

                        var self = this;
                        this.feedbackContainer().each(function (i, el) {
                            var container = $(el);
                            var linkContext = container.siblings('div .providerPreLinking').data('linkContext');

                            container.fadeOut('slow', function () {
                                if (linkContext === 'checkout-new') {
                                    feedbackMsg = self.feedbackMessage('checkout-new');
                                } else {
                                    feedbackMsg = self.feedbackMessage('login_to_link-signin-required');
                                }
                                container.removeClass('alert-danger alert-success alert-info')
                                    .addClass('alert alert-warning')
                                    .html(icon + feedbackMsg).fadeIn('fast');
                            });
                        });
                    }
                }

                break;

            case "other_user_exists":
                feedbackMsg = this.feedbackMessage('other_user_exists');
                this.feedbackContainer().removeClass('alert-info alert-success')
                    .addClass('alert alert-danger')
                    .html(icon + feedbackMsg).slideDown();
                break;

            case "already_linked":
                feedbackMsg = this.feedbackMessage('already_linked');
                this.feedbackContainer().removeClass('alert-info alert-success')
                    .addClass('alert alert-danger')
                    .html(icon + feedbackMsg).slideDown();
                break;

            default:
                feedbackMsg = this.feedbackMessage('default');
                this.feedbackContainer().removeClass('alert-info alert-success')
                    .addClass('alert alert-danger')
                    .html(icon + feedbackMsg).slideDown();
                break;
        }
    };

    this.signIn = function (config, context, provider, providerDone, providerError) {
        jQuery.ajax(config).done(function(data) {
            providerDone();
            WHMCS.authn.provider.displaySuccess(data, context, provider);
            var table = jQuery('#tableLinkedAccounts');
            if (table.length) {
                WHMCS.ui.dataTable.getTableById('tableLinkedAccounts').ajax.reload();
            }
        }).error(function() {
            providerError();
            WHMCS.authn.provider.displayError();
        });
    };

    return this;
}});

/**
 * WHMCS client module
 *
 * @copyright Copyright (c) WHMCS Limited 2005-2017
 * @license http://www.whmcs.com/license/ WHMCS Eula
 */
(function(module) {
    if (!WHMCS.hasModule('client')) {
        WHMCS.loadModule('client', module);
    }
})({
registration: function () {
    this.prefillPassword = function (params) {
        params = params || {};
        if (typeof params.hideContainer === 'undefined') {
            var id = (jQuery('#inputSecurityQId').attr('id')) ? '#containerPassword' : '#containerNewUserSecurity';
            params.hideContainer = jQuery(id);
            params.hideInputs = true;
        } else if (typeof params.hideContainer === 'string' && params.hideContainer.length) {
            params.hideContainer = jQuery(params.hideContainer);
        }

        if (typeof params.form === 'undefined') {
            params.form = {
                password: [
                    {id: 'inputNewPassword1'},
                    {id: 'inputNewPassword2'}
                ]
            };
        }

        var prefillFunc = function () {
            var $randomPasswd = WHMCS.utils.simpleRNG();
            for (var i = 0, len = params.form.password.length; i < len; i++) {
                jQuery('#' + params.form.password[i].id)
                    .val($randomPasswd).trigger('keyup');
            }
        };

        if (params.hideInputs) {
            params.hideContainer.slideUp('fast', prefillFunc);
        } else {
            prefillFunc();
        }
    };

    return this;
}});

/**
 * WHMCS UI module
 *
 * @copyright Copyright (c) WHMCS Limited 2005-2017
 * @license http://www.whmcs.com/license/ WHMCS Eula
 */
(function(module) {
    if (!WHMCS.hasModule('ui')) {
        WHMCS.loadModule('ui', module);
    }
})({
/**
 * Confirmation PopUp
 */
confirmation: function () {

    /**
     * @type {Array} Registered confirmation root selectors
     */
    var toggles = [];

    /**
     * Register/Re-Register all confirmation elements with jQuery
     * By default all elements of data toggle "confirmation" will be registered
     *
     * @param {(string|undefined)} rootSelector
     * @return {Array} array of registered toggles
     */
    this.register = function (rootSelector) {
        if (typeof rootSelector === 'undefined') {
            rootSelector = '[data-toggle=confirmation]';
        }
        if (toggles.indexOf(rootSelector) < 0) {
            toggles.push(rootSelector);
        }

        jQuery(rootSelector).confirmation({
            rootSelector: rootSelector
        });

        return toggles;
    };

    return this;
},

/**
 * Data Driven Table
 */
dataTable: function () {

    /**
     * @type {{}}
     */
    this.tables = {};

    /**
     * Register all tables on page with the class "data-driven"
     */
    this.register = function () {
        var self = this;
        jQuery('table.data-driven').each(function (i, table) {
            self.getTableById(table.id, undefined);
        });
    };

    /**
   * Get a table by id; create table object on fly as necessary
   *
   * @param {string} id
   * @param {({}|undefined)} options
   * @returns {DataTable}
   */
  this.getTableById = function (id, options) {
      var self = this;
      var el = jQuery('#' + id);
      if (typeof self.tables[id] === 'undefined') {
          if (typeof options === 'undefined') {

              options = {
                  dom: '<"listtable"ift>pl',
                  paging: false,
                  searching: false,
                  ordering: true,
                  info: false,
                  language: {
                      emptyTable: (el.data('lang-empty-table')) ? el.data('lang-empty-table') : "No records found"
                  },
                  ajax: {
                      url: el.data("ajax-url")
                  }
              };
          }
          var ordering = el.data('ordering');
          if (typeof ordering !== 'undefined') {
              options["ordering"] = ordering;
          }
          var order = el.data('order');
          if (typeof order !== 'undefined' && order) {
              options["order"] = order;
          }
          var colCss = el.data('columns');
          if (typeof colCss !== 'undefined' && colCss) {
              options["columns"] = colCss;
          }
          var autoWidth = el.data('auto-width');
          if (typeof autoWidth !== 'undefined') {
              options["bAutoWidth"] = autoWidth;
          }

          self.tables[id] = self.initTable(el, options);
      } else if (typeof options !== 'undefined') {
          var oldTable = self.tables[id];
          var initOpts = oldTable.init();
          var newOpts = jQuery.extend( initOpts, options);
          oldTable.destroy();
          self.tables[id] = self.initTable(el, newOpts);
      }

      return self.tables[id];
  };

  this.initTable = function (el, options) {
      var table = el.DataTable(options);
      var self = this;
      if (el.data('on-draw')) {
          table.on('draw.dt', function (e, settings) {
              var namedCallback = el.data('on-draw');
              if (typeof window[namedCallback] === 'function') {
                  window[namedCallback](e, settings);
              }
          });
      } else if (el.data('on-draw-rebind-confirmation')) {
          table.on('draw.dt', function (e) {
              self.rebindConfirmation(e);
          });
      }

      return table;
  };

  this.rebindConfirmation = function (e) {
      var self = this;
      var tableId = e.target.id;
      var toggles = WHMCS.ui.confirmation.register();
      for(var i = 0, len = toggles.length; i < len; i++ ) {
          jQuery(toggles[i]).on(
              'confirmed.bs.confirmation',
              function (e)
              {
                  e.preventDefault();
                  jQuery.post(
                      jQuery(e.target).data('target-url'),
                      {
                          'token': csrfToken
                      }
                  ).done(function (data)
                  {
                      if (data.status === 'success' || data.status === 'okay') {
                          self.getTableById(tableId, undefined).ajax.reload();
                      }
                  });

              }
          );
      }
  };

  return this;
},

/**
* ToolTip and Clipboard behaviors
*/
toolTip: function () {
  this.registerClipboard = function () {
      var self = this;
      jQuery('[data-toggle="tooltip"]').tooltip();
      var clipboard = new Clipboard('.copy-to-clipboard');
      clipboard.on('success', function(e) {
          var btn = jQuery(e.trigger);
          self.setTip(btn, 'Copied!');
          self.hideTip(btn);
      });
      clipboard.on('error', function(e) {
          self.setTip(e.trigger, 'Press Ctrl+C to copy');
          self.hideTip(e.trigger);
      });
      $('.copy-to-clipboard').tooltip({
          trigger: 'click',
          placement: 'bottom'
      });
  };

  this.setTip = function (btn, message) {
      var tip = btn.data('bs.tooltip');
      if (tip.hoverState !== 'in') {
          tip.hoverState = 'in';
      }
      btn.attr('data-original-title', message);
      tip.show();

      return tip;
  };

  this.hideTip = function (btn) {
      return setTimeout(function() {
          btn.data('bs.tooltip').hide()
      }, 2000);
  }
}
});

/**
* Form module
*
* @copyright Copyright (c) WHMCS Limited 2005-2017
* @license http://www.whmcs.com/license/ WHMCS Eula
*/
(function(module) {
  if (!WHMCS.hasModule('form')) {
      WHMCS.loadModule('form', module);
  }
})(
function () {
  this.register = function () {
      this.bindCheckAll();
  };

  this.bindCheckAll = function ()
  {
      var huntSelector = '.btn-check-all';
      jQuery(huntSelector).click(function (e) {
          var btn = jQuery(e.target);
          var targetInputs = jQuery(
              '#' + btn.data('checkbox-container') + ' input[type="checkbox"]'
          );
          if (btn.data('btn-check-toggle')) {
              // one control that changes
              var textDeselect = 'Deselect All';
              var textSelect = 'Select All';
              if (btn.data('label-text-deselect')) {
                  textDeselect = btn.data('label-text-deselect');
              }
              if (btn.data('label-text-select')) {
                  textSelect = btn.data('label-text-select');
              }

              if (btn.hasClass('toggle-active')) {
                  targetInputs.prop('checked',false);
                  btn.text(textDeselect);
                  btn.removeClass('toggle-active');
              } else {
                  targetInputs.prop('checked',true);
                  btn.text(textSelect);
                  btn.addClass('toggle-active');
              }
          } else {
              // two controls that are static
              if (btn.data('btn-toggle-on')) {
                  targetInputs.prop('checked',true);
              } else {
                  targetInputs.prop('checked',false);
              }
          }
      });
  };

  return this;
});

/**
 * General utilities module
 *
 * @copyright Copyright (c) WHMCS Limited 2005-2017
 * @license http://www.whmcs.com/license/ WHMCS Eula
 */
(function(module) {
    if (!WHMCS.hasModule('utils')) {
        WHMCS.loadModule('utils', module);
    }
})(
function () {
    /**
     * Not crypto strong; server-side must discard for
     * something with more entropy; the value is sufficient
     * for strong client-side validation check
     */
    this.simpleRNG = function () {
        var chars = './$_-#!,^*()|';
        var r = 0;
        for (var i = 0; r < 3; i++) {
            r += Math.floor((Math.random() * 10) / 2);
        }
        r = Math.floor(r);
        var s = '';
        for (var x = 0; x < r; x++) {
            v = (Math.random() + 1).toString(24).split('.')[1];
            if ((Math.random()) > 0.5) {
                s += btoa(v).substr(0,4)
            } else {
                s += v
            }

            if ((Math.random()) > 0.5) {
                s += chars.substr(
                    Math.floor(Math.random() * 13),
                    1
                );
            }
        }

        return s;
    };

    return this;
});


// Default catch for all other popovers
jQuery('[data-toggle="popover"]').popover({
    html: true
});

// Logic to dismiss popovers on click outside
jQuery('body').on('click', function (e) {
    jQuery('[data-toggle="popover"]').each(function () {
        if (!jQuery(this).is(e.target) && jQuery(this).has(e.target).length === 0 && jQuery('.popover').has(e.target).length === 0) {
            jQuery(this).popover('hide');
        }
    });
});

(function(j) {
  j.fn.extend({
    accordion: function() {
      return this.each(function() {
        function b(c, b) {
          $(c).parent(d).siblings().removeClass(e).children(f).slideUp(g);
          $(c).siblings(f)[b || h](b == "show" ? g : !1, function() {
            $(c).siblings(f).is(":visible") ? $(c).parents(d).not(a.parents()).addClass(e) : $(c).parent(d).removeClass(e);
            b == "show" && $(c).parents(d).not(a.parents()).addClass(e);
            $(c).parents().show()
          })
        }
        var a = $(this), e = "active", h = "slideToggle", f = "ul, div", g = "fast", d = "li";
        if (a.data("accordiated"))
          return !1;
        $.each(a.find("ul, li>div"),
          function() {
            $(this).data("accordiated", !0);
            $(this).hide()
          });
        $.each(a.find("a"), function() {
          $(this).click(function() {
            b(this, h)
          });
          $(this).bind("activate-node", function() {
            a.find(f).not($(this).parents()).not($(this).siblings()).slideUp(g);
            b(this, "slideDown")
          })
        });
        var i = location.hash ? a.find("a[href=" + location.hash + "]")[0]: a.find("li.current a")[0];
        i && b(i, !1)
      })
}
})
})(jQuery);

// Checkboxes Toggle
// ===============================
function toggleCheckboxes(classname) {
  jQuery("."+classname).attr('checked',!jQuery("."+classname+":first").is(':checked'));
}
// Disable Field Class
// ===============================
function disableFields(classname,disable) {
  if (disable) jQuery("."+classname).attr("disabled","disabled");
  else jQuery("."+classname).removeAttr("disabled");
}

/**
 * Used to toggle display of editable billing address fields.
 */
function editBillingAddress() {
    jQuery("#billingAddressSummary").hide();
    jQuery(".cc-billing-address").hide().removeClass('hidden').fadeIn();
}


/**
 * Show new credit card input fields.
 */
function showNewCardInputFields() {
    if (jQuery(".cc-details").hasClass("hidden")) {
        jQuery(".cc-details").hide().removeClass("hidden");
    }
    jQuery(".cc-details").slideDown();
    jQuery("#btnEditBillingAddress").removeAttr("disabled");
}

/**
 * Hide new credit card input fields.
 */
function hideNewCardInputFields() {
    jQuery(".cc-billing-address").slideUp();
    jQuery(".cc-details").slideUp();
    jQuery("#btnEditBillingAddress").attr("disabled", "disabled");
    if (jQuery("#billingAddressSummary").hasClass('hidden')) {
        jQuery("#billingAddressSummary").hide().removeClass('hidden').slideDown();
    } else {
        jQuery("#billingAddressSummary").slideDown();
    }
}

// Open Centered Popup
// ===============================
function popupWindow(addr,popname,w,h,features) {
  var winl = (screen.width-w)/2;
  var wint = (screen.height-h)/2;
  if (winl < 0) winl = 0;
  if (wint < 0) wint = 0;
  var settings = 'height=' + h + ',';
  settings += 'width=' + w + ',';
  settings += 'top=' + wint + ',';
  settings += 'left=' + winl + ',';
  settings += features;
  win = window.open(addr,popname,settings);
  win.window.focus();
}
// Support Tickets
// ===============================
function extraTicketAttachment() {
  jQuery("#fileuploads").append('<p><div class="input-group"><span class="input-group-btn"><span class="btn btn-default btn-sm btn-file"><span class="glyphicon glyphicon-folder-open"></span> <input type="file" name="attachments[]" multiple=""></span></span><input type="text" class="form-control input-sm" readonly=""></div></p>');
  $(document).ready( function() {
    $('.btn-file :file').on('fileselect', function(event, numFiles, label) {

      var input = $(this).parents('.input-group').find(':text'),
      log = numFiles > 1 ? numFiles + ' files selected' : label;

      if( input.length ) {
        input.val(log);
      } else {
        if( log ) alert(log);
      }

    });
  });
}
function rating_hover(id) {
    var selrating=id.split('_');
    for(var i=1; i<=5; i++){
        if(i<=selrating[1]) document.getElementById(selrating[0]+'_'+i).childNodes[0].className="glyphicon glyphicon-star";
        if(i>selrating[1]) document.getElementById(selrating[0]+'_'+i).childNodes[0].className="glyphicon glyphicon-star-empty";
    }
}
function rating_leave(id){
    for(var i=1; i<=5; i++){
        document.getElementById(id+'_'+i).childNodes[0].className="glyphicon glyphicon-star-empty";
    }
}
function rating_select(tid,c,id){
  window.location='viewticket.php?tid='+tid+'&c='+c+'&rating='+id;
}
// Sidebar
// ===============================
$('ul.nav-list').accordion();
$('.site-holder.container .nav > li > ul > li.active').parent().css('display','block');
$('.site-holder.container.mini-sidebar .nav > li > ul > li.active').parent().css('display','none');
$('.btn-nav-toggle-responsive').click(function(){
  $('.left-sidebar').toggleClass('show-fullsidebar');
});
$('li.nav-toggle > button').click(function(e){
        //Set cookie
        if($.cookie('minibar')==null||$.cookie('minibar')==0) {
          $.cookie('minibar',1);
          $('li.submenu').removeClass('active');
          $('li.submenu > ul').hide();
          $('.fa.arrow.rotate').removeClass('down');
        }
        else {
          $.cookie('minibar',0);
        }
        e.preventDefault();
        changeSidebarState();
      });
    //Load sidebar state
    $(function(){
      if($.cookie('minibar')==1) {
        changeSidebarStateNoAnimate();
      }
    });
    function changeSidebarState(){
      $('.hidden-minibar').toggleClass("hide");
      $('.site-holder').toggleClass("mini-sidebar");

      if($('.toggle-right').hasClass('fa-angle-double-right')){ $('.toggle-right').removeClass('fa-angle-double-right').addClass('fa-angle-double-left'); }
            else { $('.toggle-right').removeClass('fa-angle-double-left').addClass('fa-angle-double-right'); }

      if($('.toggle-left').hasClass('fa-angle-double-left')){ $('.toggle-left').removeClass('fa-angle-double-left').addClass('fa-angle-double-right'); }
            else { $('.toggle-left').removeClass('fa-angle-double-right').addClass('fa-angle-double-left'); }

      if($('.site-holder').hasClass('mini-sidebar'))
      {
        $('.sidebar-holder').tooltip({
          selector: "a",
          container: "body",
          placement: "right"
        });
        $('li.submenu ul').tooltip('destroy');
      }
      else
      {
        $('.sidebar-holder').tooltip('destroy');
      }
    }
    function changeSidebarStateNoAnimate(){
      $('.toggle-left').removeClass('fa-angle-double-left').addClass('fa-angle-double-right');
      $('.toggle-right').removeClass('fa-angle-double-right').addClass('fa-angle-double-left');
      if($('.site-holder').hasClass('mini-sidebar'))
      {
        $('.sidebar-holder').tooltip({
          selector: "a",
          container: "body",
          placement: "right"
        });
        $('li.submenu ul').tooltip('destroy');
      }
      else
      {
        $('.sidebar-holder').tooltip('destroy');
      }
    }
      //
      if($('.site-holder').hasClass('mini-sidebar'))
      {
        $('.sidebar-holder').tooltip({
          selector: "a",
          container: "body",
          placement: "right"
        });
        $('li.submenu').tooltip('destroy');
      }
      else
      {
        $('.sidebar-holder').tooltip('destroy');
      }
      $('.show-info').click(function(){
       $(this).toggleClass("down");
        $('.page-information').toggleClass('hidden');
      });

      $('.site-holder.mini-sidebar .content').click(function () {
       $('.site-holder.mini-sidebar li.submenu ul').hide();
       $('.site-holder.mini-sidebar li.submenu').removeClass('active');

     });

// Rotate icon
// ===============================
$(".sidebar-holder .nav a.dropdown").click(function(){
$('.rotate', this).toggleClass("down")  ;
})


// Language Dropdown
// ===============================


$('.settings-toggle').click(function(e){
  e.preventDefault();
  $('.right-sidebar').toggleClass('right-sidebar-hidden');
});
$('.theme-panel-close').click(function(){
  $('.right-sidebar').toggleClass('right-sidebar-hidden');
});

$(function(){
  $('.right-sidebar-holder').perfectScrollbar();
});

// Scrollbar
// ===============================


$(function(){
  $('.ps-messages').perfectScrollbar();
});

$(function(){
  $('.ps-languages').perfectScrollbar();
});

$(function(){
  $('.server-list').perfectScrollbar();
});

// Server List
// ===============================


$(function(){
        $('.server-list').tooltip({
          selector: "a",
          container: "body",
          placement: "top"
        });
});

 // Enable Switches for Checkboxes
    if (jQuery.prototype.bootstrapSwitch) {
        jQuery(".toggle-switch-success").bootstrapSwitch({
            onColor: 'success'
        });
    }

// Handle Single Sign-On Toggle Setting
    jQuery("#inputAllowSso").on('switchChange.bootstrapSwitch', function(event, isChecked) {
        if (isChecked) {
            jQuery("#ssoStatusTextEnabled").removeClass('hidden').show();
            jQuery("#ssoStatusTextDisabled").hide();
        } else {
            jQuery("#ssoStatusTextDisabled").removeClass('hidden').show();
            jQuery("#ssoStatusTextEnabled").hide();
        }
        jQuery.post("clientarea.php", jQuery("#frmSingleSignOn").serialize());
    });


    // Single Sign-On call for Product/Service
    jQuery('.btn-service-sso').on('click', function(e) {
        e.preventDefault();
        var button = jQuery(this);

        var form = button.parents('form');

        if (form.length == 0) {
            form = button.find('form');
        }
        if (form.hasClass('disabled')) {
            return;
        }

        button.find('.loading').removeClass('hidden').show().end()
            .attr('disabled', 'disabled');
        jQuery.post(
            window.location.href,
            form.serialize(),
            function (data) {
                button.find('.loading').hide().end().removeAttr('disabled');
                form.find('.login-feedback').html('');
                if (data.error) {
                    form.find('.login-feedback').html(data.error);
                }
                if (data.redirect !== undefined && data.redirect.substr(0, 7) === 'window|') {
                    window.open(data.redirect.substr(7), '_blank');
                }
            },
            'json'
        );
    });
    jQuery('.btn-sidebar-form-submit').on('click', function(e) {
        e.preventDefault();
        jQuery(this).find('.loading').removeClass('hidden').show().end()
            .attr('disabled', 'disabled');

        var form = jQuery(this).parents('form');

        if (form.length == 0) {
            form = jQuery(this).find('form');
        }

        if (form.length !== 0 && form.hasClass('disabled') === false) {
            form.submit();
        } else {
            jQuery(this).find('.loading').hide().end().removeAttr('disabled');
        }
    });

    // Email verification close
    jQuery('.email-verification .btn.close').click(function(e) {
        e.preventDefault();
        jQuery.post('clientarea.php', 'action=dismiss-email-banner&token=' + csrfToken);
        jQuery('.email-verification').hide();
    });

    // Back to top animated scroll
    jQuery('.back-to-top').click(function(e) {
        e.preventDefault();
        jQuery('body,html').animate({scrollTop: 0}, 500);
    });

    // Prevent page scroll on language choose click
    jQuery('.choose-language').click(function(e) {
        e.preventDefault();
    });



// Sub-Account Activation Toggle
    jQuery("#inputSubaccountActivate").click(function () {
        if (jQuery("#inputSubaccountActivate:checked").val() != null) {
            jQuery("#subacct-container").removeClass('hidden');
        } else {
            jQuery("#subacct-container").addClass('hidden');
        }
    });

/**
 * Add domain renewal to shopping cart.
 *
 * @param {number} renewalID    The domain ID to be added
 * @param {domElement} selfThis The object triggering the add
 */
function addRenewalToCart(renewalID, selfThis) {
    jQuery("#domainRow" + renewalID).attr('disabled', 'disabled');
    jQuery("#domainRow" + renewalID).find("select,button").attr("disabled", "disabled");
    jQuery(selfThis).html('<span class="glyphicon glyphicon-shopping-cart"></span> Adding...');
    var renewalPeriod = jQuery("#renewalPeriod" + renewalID).val();
    jQuery.post(
        "clientarea.php",
        "addRenewalToCart=1&token=" + csrfToken + "&renewID="+ renewalID + "&period=" + renewalPeriod,
        function( data ) {
            jQuery("#cartItemCount").html(((jQuery("#cartItemCount").html() * 1) + 1));
            jQuery(selfThis).html('<span class="glyphicon glyphicon-shopping-cart"></span> Added');
            jQuery("#btnCheckout").fadeIn();
        }
    );
}

    // Mass Domain Management Bulk Action Handling
    jQuery(".setBulkAction").click(function(event) {
        event.preventDefault();
        var id = jQuery(this).attr('id').replace("Link", "");
        if (jQuery("#" + id).length != 0) {
            var action = jQuery("#domainForm").attr("action");
            jQuery("#domainForm").attr("action", action + "#" + id);
        }
        jQuery("#bulkaction").val(id);
        jQuery("#domainForm").submit();
    });

/**
 * Submit default whois info and disable custom fields.
 *
 * @param {string} regType The contact registration type
 */
function useDefaultWhois(regType) {
    jQuery("." + regType.substr(0, regType.length - 1) + "customwhois").attr("disabled", true);
    jQuery("." + regType.substr(0, regType.length - 1) + "defaultwhois").attr("disabled", false);
    jQuery('#' + regType.substr(0, regType.length - 1) + '1').attr("checked", "checked");
}

/**
 * Submit the first form that exists within a given container.
 *
 * @param {string} containerId The ID name of the container
 */
function autoSubmitFormByContainer(containerId) {
    jQuery("#" + containerId).find("form:first").submit();
}

/**
 * Submit custom fields and disable default whois info.
 *
 * @param {string} regType The contact registration type
 */
function useCustomWhois(regType) {
    jQuery("." + regType.substr(0, regType.length - 1) + "customwhois").attr("disabled", false);
    jQuery("." + regType.substr(0, regType.length - 1) + "defaultwhois").attr("disabled", true);
    jQuery('#' + regType.substr(0, regType.length - 1) + '2').attr("checked", "checked");
}


if (typeof Waves !== 'undefined') {
  Waves.init();
  Waves.attach(".sidebar-holder .nav a", ["waves-light", "waves-round"]);
}


/*!
 * WHMCS Ajax Driven Modal Framework
 *
 * @copyright Copyright (c) WHMCS Limited 2005-2016
 * @license http://www.whmcs.com/license/ WHMCS Eula
 */
jQuery(document).ready(function(){
    jQuery(document).on('click', '.open-modal', function(e) {
        e.preventDefault();
        var url = jQuery(this).attr('href'),
            modalSize = jQuery(this).data('modal-size'),
            modalClass = jQuery(this).data('modal-class'),
            modalTitle = jQuery(this).data('modal-title'),
            submitId = jQuery(this).data('btn-submit-id'),
            submitLabel = jQuery(this).data('btn-submit-label'),
            hideClose = jQuery(this).data('btn-close-hide'),
            disabled = jQuery(this).attr('disabled'),
            successDataTable = jQuery(this).data('datatable-reload-success');

        if (!disabled) {
            openModal(url, '', modalTitle, modalSize, modalClass, submitLabel, submitId, hideClose, successDataTable);
        }
    });

    // define modal close reset action
    jQuery('#modalAjax').on('hidden.bs.modal', function (e) {
        if (jQuery(this).hasClass('modal-feature-highlights')) {
            var dismissForVersion = jQuery('#cbFeatureHighlightsDismissForVersion').is(':checked');
            jQuery.post(
                'whatsnew.php',
                {
                    dismiss: "1",
                    until_next_update: dismissForVersion ? '1' : '0',
                    token: csrfToken
                }
            );
        }

        jQuery('#modalAjax').find('.modal-body').empty();
        jQuery('#modalAjax').children('div.modal-dialog').removeClass('modal-lg');
        jQuery('#modalAjax').removeClass().addClass('modal whmcs-modal fade');
        jQuery('#modalAjax .modal-title').html('Title');
        jQuery('#modalAjax .modal-submit').html('Submit')
            .removeClass()
            .addClass('btn btn-primary modal-submit')
            .removeAttr('id')
            .removeAttr('disabled');
        jQuery('#modalAjax .loader').show();
    });
});

function openModal(url, postData, modalTitle, modalSize, modalClass, submitLabel, submitId, hideClose, successDataTable) {
    //set the text of the modal title
    jQuery('#modalAjax .modal-title').html(modalTitle);

    // set the modal size via a class attribute
    if (modalSize) {
        jQuery('#modalAjax').children('div[class="modal-dialog"]').addClass(modalSize);
    }
    // set the modal class
    if (modalClass) {
        jQuery('#modalAjax').addClass(modalClass);
    }

    // set the modal class
    if (modalClass) {
        jQuery('#modalAjax').addClass(modalClass);
    }

    // set the text of the submit button
    if(!submitLabel){
       jQuery('#modalAjax .modal-submit').hide();
    } else {
        jQuery('#modalAjax .modal-submit').show().html(submitLabel);
        // set the button id so we can target the click function of it.
        if (submitId) {
            jQuery('#modalAjax .modal-submit').attr('id', submitId);
        }
    }

    if (hideClose) {
        jQuery('#modalAjaxClose').hide();
    }

    jQuery('#modalAjax .modal-body').html('');

    jQuery('#modalSkip').hide();
    jQuery('#modalAjax .modal-submit').prop('disabled', true);

    // show modal
    jQuery('#modalAjax').modal('show');

    // fetch modal content
    jQuery.post(url, postData, function(data) {
        updateAjaxModal(data);
    }, 'json').fail(function() {
        jQuery('#modalAjax .modal-body').html('An error occurred while communicating with the server. Please try again.');
        jQuery('#modalAjax .loader').fadeOut();
    });

    //define modal submit button click
    if (submitId) {
        /**
         * Reloading ajax modal multiple times on the same page can add
         * multiple "on" click events which submits the same form over
         * and over.
         * Remove the on click event with "off" to avoid multiple growl
         * and save events being run.
         *
         * @see http://api.jquery.com/off/
         */
        var submitButton = jQuery('#' + submitId);
        submitButton.off('click');
        submitButton.on('click', function() {
            var modalForm = jQuery('#modalAjax').find('form');
            jQuery('#modalAjax .loader').show();
            var modalPost = jQuery.post(
                modalForm.attr('action'),
                modalForm.serialize(),
                function(data) {
                    if (successDataTable) {
                        data.successDataTable = successDataTable;
                    }
                    updateAjaxModal(data);
                },
                'json'
            ).fail(function(xhr) {
                var data = xhr.responseJSON;
                var genericErrorMsg = 'An error occurred while communicating with the server. Please try again.';
                if (data && data.data) {
                    data = data.data;
                    if (data.errorMsg) {
                        jQuery.growl.warning({ title: data.errorMsgTitle, message: data.errorMsg });
                    } else if (data.data.body) {
                        jQuery('#modalAjax .modal-body').html(data.body);
                    } else {
                        jQuery('#modalAjax .modal-body').html(genericErrorMsg);
                    }
                } else {
                    jQuery('#modalAjax .modal-body').html(genericErrorMsg);
                }
                jQuery('#modalAjax .loader').fadeOut();
            });
        })
    }
}

function updateAjaxModal(data) {
    if (data.successDataTable) {
        WHMCS.ui.dataTable.getTableById(data.successDataTable, undefined).ajax.reload();
    }
    if (data.dismiss) {
        dialogClose();
    }
    if (data.successMsg) {
        jQuery.growl.notice({ title: data.successMsgTitle, message: data.successMsg });
    }
    if (data.errorMsg) {
        jQuery.growl.warning({ title: data.errorMsgTitle, message: data.errorMsg });
    }
    if (data.title) {
        jQuery('#modalAjax .modal-title').html(data.title);
    }
    if (data.body) {
        jQuery('#modalAjax .modal-body').html(data.body);
    } else {
        if (data.url) {
            jQuery.post(data.url, '', function(data2) {
                jQuery('#modalAjax').find('.modal-body').html(data2.body);
            }, 'json').fail(function() {
                jQuery('#modalAjax').find('.modal-body').html('An error occurred while communicating with the server. Please try again.');
                jQuery('#modalAjax').find('.loader').fadeOut();
            });
        }
    }
    if (data.submitlabel) {
        jQuery('#modalAjax .modal-submit').html(data.submitlabel).show();
        if (data.submitId) {
            jQuery('#modalAjax').find('.modal-submit').attr('id', data.submitId);
        }
    }

    if (data.submitId) {
        /**
         * Reloading ajax modal multiple times on the same page can add
         * multiple "on" click events which submits the same form over
         * and over.
         * Remove the on click event with "off" to avoid multiple growl
         * and save events being run.
         *
         * @see http://api.jquery.com/off/
         */
        var submitButton = jQuery('#' + data.submitId);
        submitButton.off('click');
        submitButton.on('click', function() {
            var modalForm = jQuery('#modalAjax').find('form');
            jQuery('#modalAjax .loader').show();
            var modalPost = jQuery.post(modalForm.attr('action'), modalForm.serialize(),
                function(data) {
                    updateAjaxModal(data);
                }, 'json').fail(function() {
                    jQuery('#modalAjax .modal-body').html('An error occurred while communicating with the server. Please try again.');
                    jQuery('#modalAjax .loader').fadeOut();
                }
            );
        })
    }

    jQuery('#modalAjax .loader').fadeOut();
    jQuery('#modalAjax .modal-submit').removeProp('disabled');
}

// backwards compat for older dialog implementations

function dialogSubmit() {
    jQuery('#modalAjax .modal-submit').prop("disabled", true);
    jQuery('#modalAjax .loader').show();
    jQuery.post('', jQuery('#modalAjax').find('form').serialize(),
        function(data) {
            updateAjaxModal(data);
        }, 'json').fail(function() {
            jQuery('#modalAjax .modal-body').html('An error occurred while communicating with the server. Please try again.');
            jQuery('#modalAjax .loader').fadeOut();
        });
}

function dialogClose() {
    jQuery('#modalAjax').modal('hide');
}




jQuery(document).ready(function() {

    /**
     * Code will loop through each element that has the class markdown-editor and
     * enable the Markdown editor.
     */
    var count = 0,
        editorName = 'clientMDE',
        counter = 0;
    jQuery(".markdown-editor").each(function( index ) {
        count++;
        var autoSaveName = jQuery(this).data('auto-save-name'),
            footerId = jQuery(this).attr('id') + '-footer';
        if (typeof autoSaveName == "undefined") {
            autoSaveName = 'client_area';
        }
        window[editorName + count.toString()] = jQuery(this).markdown(
        {
            footer: '<div id="' + footerId + '" class="markdown-editor-status"></div>',
            autofocus: false,
            savable: false,
            resize: 'vertical',
            iconlibrary: 'fa',
            language: locale,
            onShow: function(e){
                var content = '',
                    save_enabled = false;
                if(typeof(Storage) !== "undefined") {
                    // Code for localStorage/sessionStorage.
                    content = localStorage.getItem(autoSaveName);
                    save_enabled = true;
                    if (content && typeof(content) !== "undefined") {
                        e.setContent(content);
                    }
                }
                jQuery("#" + footerId).html(parseMdeFooter(content, save_enabled, saved));
            },
            onChange: function(e){
                var content = e.getContent(),
                    save_enabled = false;
                if(typeof(Storage) !== "undefined") {
                    counter = 3;
                    save_enabled = true;
                    localStorage.setItem(autoSaveName, content);
                    doCountdown();
                }
                jQuery("#" + footerId).html(parseMdeFooter(content, save_enabled));
            },
            onPreview: function(e){
                var originalContent = e.getContent(),
                    parsedContent;

                jQuery.ajax({
                    url: 'clientarea.php',
                    async: false,
                    data: {token: csrfToken, action: 'parseMarkdown', content: originalContent},
                    dataType: 'json',
                    success: function (data) {
                        parsedContent = data;
                    }
                });

                return parsedContent.body ? parsedContent.body : '';
            },
            additionalButtons: [
                [{
                    name: "groupCustom",
                    data: [{
                        name: "cmdHelp",
                        title: "Help",
                        hotkey: "Ctrl+F1",
                        btnClass: "btn open-modal",
                        icon: {
                            glyph: 'glyphicons glyphicons-question-sign',
                            fa: 'fa fa-question-circle',
                            'fa-3': 'icon-question-sign'
                        },
                        callback: function(e) {
                            e.$editor.removeClass("md-fullscreen-mode");
                        }
                    }]
                }]
            ],
            hiddenButtons: [
                'cmdImage'
            ]
        });
        jQuery('button[data-handler="bootstrap-markdown-cmdHelp"]')
            .attr('data-modal-title', markdownGuide)
            .attr('href', 'submitticket.php?action=markdown');

        jQuery(this).closest("form").bind({
            submit: function() {
                if(typeof(Storage) !== "undefined") {
                    localStorage.removeItem(autoSaveName);
                }
            }
        });
    });

    // Email verification
    jQuery('#btnResendVerificationEmail').click(function() {
        jQuery.post('clientarea.php',
            {
                'token': csrfToken,
                'action': 'resendVerificationEmail'
            }).done(function(data) {
                jQuery('#btnResendVerificationEmail').html('Email Sent').prop('disabled', true);
            });
    });

    /**
     * Parse the content to populate the markdown editor footer.
     *
     * @param {string} content
     * @param {bool} auto_save
     * @param {string} [saveText]
     * @returns {string}
     */
    function parseMdeFooter(content, auto_save, saveText)
    {
        saveText = saveText || saving;
        var pattern = /[a-zA-Z0-9_\u0392-\u03c9]+|[\u4E00-\u9FFF\u3400-\u4dbf\uf900-\ufaff\u3040-\u309f\uac00-\ud7af]+/g,
            m = [],
            word_count = 0,
            line_count = 0;
        if (content) {
            m = content.match(pattern);
            line_count = content.split(/\\r\\n|\\r|\\n/).length;
        }
        for(var i = 0; i < m.length; i++) {
            if(m[i].charCodeAt(0) >= 0x4E00) {
                word_count += m[i].length;
            } else {
                word_count += 1;
            }
        }
        return '<div class="small-font">lines: ' + line_count
            + '&nbsp;&nbsp;&nbsp;words: ' + word_count + ''
            + (auto_save ? '&nbsp;&nbsp;&nbsp;<span class="markdown-save">' + saveText + '</span>' : '')
            + '</div>';
    }

    /**
     * Countdown the save timeout. When zero, the span will update to show saved.
     */
    function doCountdown()
    {
        if (counter >= 0) {
            if (counter == 0) {
                jQuery("span.markdown-save").html(saved);
            }
            counter--;
            setTimeout(doCountdown, 1000);
        }
    }

    // Two-Factor Activation Process Modal Handler.
    var frmTwoFactorActivation = jQuery('input[name=2fasetup]').parent('form');
    frmTwoFactorActivation.submit(function(e) {
        e.preventDefault();
        openModal(frmTwoFactorActivation.attr('action'), frmTwoFactorActivation.serialize(), 'Loading...');
    });

    jQuery('#frmPayment').find('#btnSubmit').on('click', function(){
        jQuery(this).find('span').toggleClass('hidden');
    });
    // SSL Manage Action Button.
jQuery('.btn-resend-approver-email').click(function () {
    jQuery.post(
        jQuery(this).data('url'),
        {
            addonId: jQuery(this).data('addonid'),
            serviceId: jQuery(this).data('serviceid'),
        },
        function(data) {
            if (data.success == true) {
                jQuery('.alert-table-ssl-manage').addClass('alert-success').text('Approver Email Resent').removeClass('hidden');
            } else {
                jQuery('.alert-table-ssl-manage').addClass('alert-danger').text('Error: ' + data.message).removeClass('hidden');
            }
        }
    );
});
// DataTable data-driven auto object registration
WHMCS.ui.dataTable.register();

// Bootstrap Confirmation popup auto object registration
WHMCS.ui.confirmation.register();

jQuery('#frmReply').submit(function(e) {
    jQuery('#frmReply').find('input[type="submit"]').addClass('disabled').prop('disabled', true);
});
});

/**
 * WHMCS Telephone Country Code Dropdown
 *
 * Using https://github.com/jackocnr/intl-tel-input
 *
 * @copyright Copyright (c) WHMCS Limited 2005-2017
 * @license http://www.whmcs.com/license/ WHMCS Eula
 */

jQuery(document).ready(function() {
    if (jQuery('body').data('phone-cc-input')) {
        var phoneInput = jQuery('input[name^="phone"], input[name$="phone"]').not('input[type="hidden"]');
        if (phoneInput.length) {
            var countryInput = jQuery('[name^="country"], [name$="country"]'),
                initialCountry = 'us',
                inputName = phoneInput.attr('name');
            if (countryInput.length) {
                initialCountry = countryInput.val().toLowerCase();
                if (initialCountry === 'um') {
                    initialCountry = 'us';
                }
            }
            phoneInput.before('<input id="populatedCountryCode' + inputName + '" type="hidden" name="country-calling-code-' + inputName + '" value="" />');
            phoneInput.intlTelInput({
                preferredCountries: [initialCountry, "us", "gb"].filter(function(value, index, self) {
                    return self.indexOf(value) === index;
                }),
                initialCountry: initialCountry,
                autoPlaceholder: 'polite', //always show the helper placeholder
                separateDialCode: true
            });

            phoneInput.on('countrychange', function (e, countryData) {
                jQuery('#populatedCountryCode' + inputName).val(countryData.dialCode);
                if (jQuery(this).val() === '+' + countryData.dialCode) {
                    jQuery(this).val('');
                }
            });
            phoneInput.on('blur keydown', function (e) {
                if (e.type === 'blur' || (e.type === 'keydown' && e.keyCode === 13)) {
                    var number = jQuery(this).intlTelInput("getNumber"),
                        countryData = jQuery(this).intlTelInput("getSelectedCountryData");
                    number = number.replace('+' + countryData.dialCode, '');
                    jQuery(this).intlTelInput("setNumber", number);
                }
            });
            jQuery('#populatedCountryCode' + inputName).val(phoneInput.intlTelInput('getSelectedCountryData').dialCode);

            countryInput.on('change', function() {
                if (phoneInput.val() === '') {
                    var country = jQuery(this).val().toLowerCase();
                    if (country === 'um') {
                        country = 'us';
                    }
                    phoneInput.intlTelInput('setCountry', country);
                }
            });

            /**
             * In places where a form icon is present, hide it.
             * Where the input has a class of field, remove that and add form-control in place.
             */
            phoneInput.parents('div.form-group').find('.field-icon').addClass('hidden').end();
            phoneInput.removeClass('field').addClass('form-control');
        }

        var registrarPhoneInput = jQuery('input[name$="][Phone Number]"], input[name$="][Phone]"]').not('input[type="hidden"]');
        if (registrarPhoneInput.length) {
            jQuery.each(registrarPhoneInput, function(index, input) {
                var thisInput = jQuery(this),
                    inputName = thisInput.attr('name');
                inputName = inputName.replace('contactdetails[', '').replace('][Phone Number]', '').replace('][Phone]', '');

                var countryInput = jQuery('[name$="' + inputName + '][Country]"]'),
                    initialCountry = countryInput.val().toLowerCase();
                if (initialCountry === 'um') {
                    initialCountry = 'us';
                }

                thisInput.before('<input id="populated' + inputName + 'CountryCode" type="hidden" name="contactdetails[' + inputName + '][Phone Country Code]" value="" />');
                thisInput.intlTelInput({
                    preferredCountries: [initialCountry, "us", "gb"].filter(function(value, index, self) {
                        return self.indexOf(value) === index;
                    }),
                    initialCountry: initialCountry,
                    autoPlaceholder: 'polite', //always show the helper placeholder
                    separateDialCode: true
                });

                thisInput.on('countrychange', function (e, countryData) {
                    jQuery('#populated' + inputName + 'CountryCode').val(countryData.dialCode);
                    if (jQuery(this).val() === '+' + countryData.dialCode) {
                        jQuery(this).val('');
                    }
                });
                thisInput.on('blur keydown', function (e) {
                    if (e.type === 'blur' || (e.type === 'keydown' && e.keyCode === 13)) {
                        var number = jQuery(this).intlTelInput("getNumber"),
                            countryData = jQuery(this).intlTelInput("getSelectedCountryData");
                        number = number.replace('+' + countryData.dialCode, '');
                        jQuery(this).intlTelInput("setNumber", number);
                    }
                });
                jQuery('#populated' + inputName + 'CountryCode').val(thisInput.intlTelInput('getSelectedCountryData').dialCode);

                countryInput.on('blur', function() {
                    if (thisInput.val() === '') {
                        var country = jQuery(this).val().toLowerCase();
                        if (country === 'um') {
                            country = 'us';
                        }
                        thisInput.intlTelInput('setCountry', country);
                    }
                });

            });
        }
    }
});
