{include file="$template/pageheader.tpl" title=$LANG.clientareanavsupporttickets desc=$LANG.supportticketsintro icon=support}
{include file="$template/includes/tablelist.tpl" tableName="TicketsList" filterColumn="2" noSortColumns="4"}
<script type="text/javascript">
    jQuery(document).ready( function ()
    {
        var table = jQuery('#tableTicketsList').removeClass('hidden').DataTable();
        {if $orderby == 'did' || $orderby == 'dept'}
            table.order(0, '{$sort}');
        {elseif $orderby == 'subject' || $orderby == 'title'}
            table.order(1, '{$sort}');
        {elseif $orderby == 'status'}
            table.order(2, '{$sort}');
        {elseif $orderby == 'lastreply'}
            table.order(3, '{$sort}');
        {/if}
        table.draw();
        jQuery('#tableLoading').addClass('hidden');
    });
</script>
<div class="table-container clearfix">
    <div class="panel panel-default panel-datatable">
    <div class="panel-heading clearfix"> {include file="$template/includes/sidebar.tpl" sidebar=$primarySidebar}</div>
    <table id="tableTicketsList" class="table table-list hidden">
        <thead>
            <tr>
                <th class="hidden-sm hidden-xs">{$LANG.supportticketsdepartment}</th>
                <th>{$LANG.supportticketssubject}</th>
                <th>{$LANG.supportticketsstatus}</th>
                <th class="hidden-sm hidden-xs">{$LANG.supportticketsticketlastupdated}</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            {foreach from=$tickets item=ticket}
                <tr>
                    <td class="hidden-sm hidden-xs">{$ticket.department}</td>
                    <td><a href="viewticket.php?tid={$ticket.tid}&amp;c={$ticket.c}">{if $ticket.unread}<strong>{/if}#{$ticket.tid} - {$ticket.subject}{if $ticket.unread}</strong>{/if}</a>

                <ul class="cell-inner-list visible-sm visible-xs small">
                    <li><span class="item-title">{$LANG.supportticketsticketlastupdated}: </span>{$ticket.lastreply}</li>
                    <li><span class="item-title">{$LANG.supportticketsdepartment}: </span>{$ticket.department}</li>
                    <li><span class="item-title">{$LANG.supportticketsticketurgency}: </span>{$ticket.urgency}</li>

                </ul>

                    </td>
                    <td><span class="label {if is_null($ticket.statusColor)}label-{$ticket.statusClass}"{else}status-custom" style="border-color: {$ticket.statusColor}; color: {$ticket.statusColor}"{/if}>{$ticket.status|strip_tags}</span></td>
                    <td class="hidden-sm hidden-xs"><span class="hidden">{$ticket.normalisedLastReply}</span>{$ticket.lastreply}</td>
                    <td class="text-right"><a class="btn btn-link" href="viewticket.php?tid={$ticket.tid}&amp;c={$ticket.c}"><i class="fa fa-chevron-right fa-lg pull-right flip"></i></a>
                    </td>
                </tr>
            {/foreach}
        </tbody>
    </table>
    <div class="text-center" id="tableLoading">
        <p><i class="fa fa-spinner fa-spin"></i> {$LANG.loading}</p>
    </div>
    </div>
</div>
