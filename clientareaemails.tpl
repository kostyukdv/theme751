{include file="$template/pageheader.tpl" title=$LANG.clientareaemails desc=$LANG.emailstagline icon=envelope}
{include file="$template/includes/tablelist.tpl" tableName="EmailsList" noSortColumns="-1"}
<script type="text/javascript">
    jQuery(document).ready( function ()
    {
        var table = jQuery('#tableEmailsList').removeClass('hidden').DataTable();
        {if $orderby == 'date'}
            table.order(0, '{$sort}');
        {elseif $orderby == 'subject'}
            table.order(1, '{$sort}');
        {/if}
        table.draw();
        jQuery('#tableLoading').addClass('hidden');
    });
</script>
<div class="table-container clearfix">
    <table id="tableEmailsList" class="table table-list hidden">
        <thead>
            <tr>
                <th class="hidden-xs">{$LANG.clientareaemailsdate}</th>
                <th>{$LANG.clientareaemailssubject}</th>
                <th>&nbsp;</th>
            </tr>
        </thead>
        <tbody>
            {foreach from=$emails item=email}
            <tr>
                <td class="hidden-xs"><span class="hidden">{$email.normalisedDate}</span>{$email.date}</td>
                <td>{$email.subject}
                    <ul class="cell-inner-list visible-xs small">
                    <li><span class="item-title">{$LANG.clientareaemailsdate}: </span>{$email.date}</li>
                    </ul>

                </td>
                <td class="text-right"><a title="{$LANG.emailviewmessage}" href="#" onclick="popupWindow('viewemail.php?id={$email.id}','emlmsg',800,400);return false;"><i class="fa fa-external-link"> </i></a></td>
            </tr>
            {/foreach}
        </tbody>
    </table>
    <div class="text-center" id="tableLoading">
        <p><i class="fa fa-spinner fa-spin"></i> {$LANG.loading}</p>
    </div>
</div>
