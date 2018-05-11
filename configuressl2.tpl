{**********************************************************************
 * Customization Services by ModulesGarden.com
 * Copyright (coffee) ModulesGarden, INBS Group Brand, All Rights Reserved 
 * (${date}, ${time})
 *
 *  CREATED BY MODULESGARDEN       ->        http://modulesgarden.com
 *  CONTACT                        ->       contact@modulesgarden.com
 *
 *
 *
 *
 * This software is furnished under a license and may be used and copied
 * only  in  accordance  with  the  terms  of such  license and with the
 * inclusion of the above copyright notice.  This software  or any other
 * copies thereof may not be provided or otherwise made available to any
 * other person.  No title to and  ownership of the  software is  hereby
 * transferred.
 *
 *
 **********************************************************************}

{**
 * @author Maciej Husak <maciej@modulesgarden.com>
 *}
 
 <h2>{$lang.cert_configuration}</h2>
 <p>&nbsp;</p>
 {if $error}
    {include file="$template/includes/alert.tpl" type="warning" msg=$error textcenter=true}
     
{/if}

 <form action="configuressl2.php?cert={$smarty.get.cert}" method="post" id="form">
     
     <table class="table sslDomains">
         <thead>
            <tr>
                <th>{$lang.domain}</th>
                {if $wildcard != "on"}<th>{$lang.withwww}</th>{/if}
                <th>{$lang.method}</th>
                {if $validation == 'Extended'}
                <th>{$lang.verification_email}</th>{/if}
            </tr>
         </thead>
         <tbody>
         {section name=foo start=1 loop=$domains_limit+1 step=1}
         <tr>
             <td>
                {$lang.domain} {$smarty.section.foo.index} <input type="text" name="domain[{$smarty.section.foo.index}]" {if $smarty.section.foo.index == 1}value="{$domain}" readonly{/if} class="domain" />
             </td>
             {if $wildcard != "on"}
             <td>
                 <input type="checkbox" name="withwww[{$smarty.section.foo.index}]" {if $smarty.section.foo.index == 1 && $withwww == 1}checked="checked" readonly="readonly" onclick="return false;"{/if} value="1" /> {$lang.add_www_prefix}
             </td>
             {/if}
                 {if $validation == 'Extended'}
                 <td>    
                     <select class="method" name="method[{$smarty.section.foo.index}]">
                         <option value=""></option>
                         <option>FILE</option>
                         <option>META</option>
                         <option>DNS</option>
                     </select>
                 </td>
                 <td>
                     <select class="email" name="emails[{$smarty.section.foo.index}]" style="width:220px;" disabled>
                        <option value=""></option>
                        {*{foreach from=$approve_emails item="email"}
                            <option value="{$email}">{$email}</option>
                        {/foreach}*}
                    </select>
                 </td>
                 {else}
                 <td>
                    <select class="method" name="method[{$smarty.section.foo.index}]">
                        <option value=""></option>
                        {$approve_method}
                    </select>&nbsp;
                    <select class="email" name="emails[{$smarty.section.foo.index}]" style="display:none" disabled>
                        <option value=""></option>
                        {*{foreach from=$approve_emails item="email"}
                            <option value="{$email}">{$email}</option>
                        {/foreach}*}
                    </select>
                 </td>
                 {/if}
         </tr>
         {/section}
         </tbody>
     </table>
         
     {if $allow_add == 'on'}
         <input type="button" class="addNew btn btn-info" value="{$lang.add_new_domain}" />
     {/if}
     <input type="hidden" name="servertype" value="{$cert_details.servertype}" />
     <input type="hidden" name="csr" value="{$cert_details.csr}" />
     {foreach from=$cert_details.fields item="entry" key="key"}
         <input type="hidden" name="fields[{$key}]" value="{$entry}" />
     {/foreach}
     <input type="hidden" name="firstname" value="{$cert_details.firstname}" />
     <input type="hidden" name="lastname" value="{$cert_details.lastname}" />
     <input type="hidden" name="orgname" value="{$cert_details.orgname}" />
     <input type="hidden" name="jobtitle" value="{$cert_details.jobtitle}" />
     <input type="hidden" name="email" value="{$cert_details.email}" />
     <input type="hidden" name="address1" value="{$cert_details.address1}" />
     <input type="hidden" name="address2" value="{$cert_details.address2}" />
     <input type="hidden" name="city" value="{$cert_details.city}" />
     <input type="hidden" name="state" value="{$cert_details.state}" />
     <input type="hidden" name="postcode" value="{$cert_details.postcode}" />
     <input type="hidden" name="country" value="{$cert_details.country}" />
     <input type="hidden" name="phonenumber" value="{$cert_details.phonenumber}" />
     {*<input type="hidden" name="token" value="{$smarty.post.token}" />*}
     
     <input type="submit" name="save" class="btn btn-success" value="{$lang.click_to_continue}" />
 </form>
 
<script type="text/javascript">
{literal}
    jQuery(document).ready(function()
    {
        jQuery("body").delegate(".addNew","click",function()
        {
           var num = jQuery(".sslDomains tbody").find("tr").length+1;
            {/literal}
            {if $validation == 'Extended'}
                {literal}
                    jQuery(".sslDomains tbody").append('<tr><td>{/literal}{$lang.domain}{literal} '+num+' <input type="text" class="domain" name="domain['+num+']" /></td>{/literal}{if $wildcard != "on"}<td><input type="checkbox" name="withwww['+num+']"  />{/if}{$lang.add_www_prefix}{literal} </td><td><select class="method" name="method['+(num)+']"><option value=""></option><option>FILE</option><option>META</option><option>DNS</option></select></td><td><select class="email" name="emails['+num+']" disabled style="width:220px;"><option></option></select></td></tr>');
                {/literal}
            {else}
                {literal}
                jQuery(".sslDomains tbody").append('<tr><td>{/literal}{$lang.domain}{literal} '+num+' <input type="text" class="domain" name="domain['+num+']" /></td><td><input type="checkbox" name="withwww['+num+']"  /> {/literal}{$lang.add_www_prefix}{literal} </td><td><select class="method" name="method['+(num)+']"><option></option>{/literal}{$approve_method}{literal}</select>&nbsp;<select class="email" name="emails['+num+']" style="display:none;" ><option></option>{/literal}{foreach from=$approve_emails item="email"}<option value="{$email}">{$email}</option>{/foreach}{literal}</select></td></tr>');
                {/literal}
            {/if}
            {literal}
            return false;
        });
        
        
        jQuery("body").delegate(".method", "change", function(){
            var domain = jQuery(this).closest("tr").find(".domain").val();
            var elem   = jQuery(this).closest("tr");
            if(domain == "" || !CheckIsValidDomain(domain))
            {
               jQuery(elem).find(".domain").css("border-color", "red").after("<span class='redalert' style='display:block;color:red;font-size:10px;'>{/literal}{$lang.error_invalid_domain}{literal}</span>");
               return false;
            } else 
            {
               jQuery(elem).find(".domain").css("border-color", "#cccccc");
               jQuery(elem).find(".redalert").remove();
            }
            
            if(jQuery(this).val() == 'EMAIL' {/literal}{if $validation == 'Extended'} || 1==1{/if}{literal})
            {
                
                jQuery(elem).find(".email").attr("disabled",true).html("<option value=''>Loading...</option>");
                jQuery.post("clientarea.php", {"_action": "getapprovedemail", "domain": domain, "serviceid": {/literal}{$serviceid}{literal}},function (data){
                    if(data.list != undefined && data.list.length > 0)
                    {
                        var emails = "<option></option>";
                        jQuery(data.list).each(function(index,value)
                        {
                           emails = emails + "<option>"+value+"</option>";
                        });
                        jQuery(elem).find(".email").html(emails).removeAttr("disabled");
                    } else if(data.result == 0)
                    {
                        alert('{/literal}{$lang.error_invalid_domain}{literal}');
                    }

                }, 'json');
                
                jQuery(this).closest("tr").find(".redalert").remove();
                jQuery(this).closest("td").find(".email").show();
                jQuery(this).css("border-color", "#cccccc");
            }      
            else
            {
                jQuery(this).closest("td").find(".email").hide();
            }   
        });
        
        jQuery("#form").submit(function(){
            jQuery(".redalert").remove();
            var sub = true;
            jQuery("input[name^=domain]").each(function(index, value)
            {
                
               if(!CheckIsValidDomain(jQuery(value).val()) && jQuery(value).val() != "")
               {
                   jQuery(value).css("border-color", "red").after("<span class='redalert' style='display:block;color:red;font-size:10px;'>{/literal}{$lang.error_invalid_domain}{literal}</span>");
                   sub = false;
               }
                
               var prefix = jQuery(value).val().substr(0,4);
               if(prefix == 'www.')
               {
                   jQuery(value).css('border-color','red');
                   jQuery(value).after("<span class='redalert' style='display:block;color:red;font-size:10px;'>{/literal}{$lang.error_name_without_prefix}{literal}</span>");
                   sub = false;
               } else 
               {
                   jQuery(value).css('border-color','#cccccc');
                   if(jQuery(value).closest("tr").find(".method").val() == "" && jQuery(value).val() !="")
                   {
                       jQuery(value).closest("tr").find(".method").css("border-color", "red").after("<span class='redalert' style='display:block;color:red;font-size:10px;'>{/literal}{$lang.error_select_method}{literal}</span>");
                       sub = false;
                   } else 
                   {
                       jQuery(value).closest("tr").find(".method").css("border-color", "#cccccc");
                   }
                   
                   if(jQuery(value).closest("tr").find(".email").val() == "" && jQuery(value).val() !="" && jQuery(value).closest("tr").find(".method").val() {/literal}{if $validation == 'Extended'} != ""{else} == "EMAIL"{/if}{literal})
                   {
                       jQuery(value).closest("tr").find(".email").css("border-color", "red").after("<span class='redalert' style='display:block;color:red;font-size:10px;'>{/literal}{$lang.error_select_email}{literal}</span>");
                       sub = false;
                   } else 
                   {
                       jQuery(value).closest("tr").find(".email").css("border-color", "#cccccc");
                   }
                   
               }
            });
            
            if(sub !== true)
                return false;
        });
        
        
        
    });
    
    function CheckIsValidDomain(domain) { 
        if(domain.substr(0,2) == '*.')
        {
            var domain = domain.substr(2);
        }
        var re = new RegExp(/^((?:(?:(?:\w[\.\-\+]?)*)\w)+)((?:(?:(?:\w[\.\-\+]?){0,62})\w)+)\.(\w{2,12})$/); 
        return domain.match(re);
    } 
{/literal}
</script>
