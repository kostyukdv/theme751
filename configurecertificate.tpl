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
 
 <h2>{$lang.cert_details}</h2>
 <p>&nbsp;</p>
 
 {if $error}
     <div class="alert alert-error">{$error}</div>
 {/if}
{if $cert->commonName != ""}
 <form action="" method="post">
     <table class="table">
        <tr>
            <td>{$lang.name}</td>
            <td>{$cert->commonName}</td>
        </tr>
        <tr>
            <td>{$lang.organization}</td>
            <td>{$cert->organization}</td>
        </tr>
        {if $cert->organizationalUnit != ""}
        <tr>
            <td>{$lang.organization_unit}</td>
            <td>{$cert->organizationalUnit}</td>
        </tr>
        {/if}
        {if $cert->street != ""}
        <tr>
            <td>{$lang.street}</td>
            <td>{$cert->street}</td>
        </tr>
        {/if}
        {if $cert->locality != ""}
        <tr>
            <td>{$lang.city}</td>
            <td>{$cert->locality}</td>
        </tr>    
        {/if}
        {if $cert->country}
        <tr>
            <td>{$lang.country}</td>
            <td>{$cert->country}</td>
        </tr>
        {/if}
        {if $cert->state != ""}
        <tr>
            <td>{$lang.state}</td>
            <td>{$cert->state}</td>
        </tr>
        {/if}
        <tr>
            <td>{$lang.email}</td>
            <td>{$cert->email}</td>
        </tr>
    </table>
    <input type="hidden" name="nextstep" value="1" />
    <input type="submit" name="save" class="btn btn-success" value="{$lang.click_to_continue}" />    
 </form>
 {else}
     <input type="button" onclick="window.location.href='configuressl.php?cert={$smarty.get.cert}';return false;" class="btn btn-warning" value="{$lang.back}" />
 {/if}
 