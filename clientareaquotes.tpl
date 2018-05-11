{include file="$template/pageheader.tpl" title=$LANG.quotestitle desc=$LANG.quotesintro icon=calculator}
{include file="$template/includes/tablelist.tpl" tableName="QuotesList"  noSortColumns="5" filterColumn="4"}
<script type="text/javascript">
    jQuery(document).ready( function ()
    {
        var table = jQuery('#tableQuotesList').removeClass('hidden').DataTable();
        {if $orderby == 'id'}
            table.order(0, '{$sort}');
        {elseif $orderby == 'date'}
            table.order(2, '{$sort}');
        {elseif $orderby == 'validuntil'}
            table.order(3, '{$sort}');
        {elseif $orderby == 'stage'}
            table.order(4, '{$sort}');
        {/if}
        table.draw();
        jQuery('#tableLoading').addClass('hidden');
    });
</script>
<div class="table-container clearfix">
    <div class="panel panel-default panel-datatable">
    <div class="panel-heading clearfix"> {include file="$template/includes/sidebar.tpl" sidebar=$primarySidebar}</div>
    <table id="tableQuotesList" class="table table-list hidden">
        <thead>
            <tr>
                <th>{$LANG.quotenumber}</th>
                <th class="hidden-sm hidden-xs">{$LANG.quotesubject}</th>
                <th class="hidden-sm hidden-xs">{$LANG.quotedatecreated}</th>
                <th class="hidden-xs">{$LANG.quotevaliduntil}</th>
                <th>{$LANG.quotestage}</th>
                <th>&nbsp;</th>
                <th class="responsive-edit-button" style="display: none;"></th>
            </tr>
        </thead>
        <tbody>
            {foreach from=$quotes item=quote}
                <tr>
                    <td><a href="dl.php?type=q&id={$quote.id}">{$quote.id}</a>

                    <ul class="cell-inner-list visible-sm visible-xs small">
                    <li><span class="item-title">{$LANG.quotesubject}</span>: {$service.nextduedate}</li>
                    <li><span class="item-title">{$LANG.quotedatecreated}: </span>{$quote.datecreated}</li>

                    <li class="hidden-sm"><span class="item-title">{$LANG.quotevaliduntil}: </span>{$quote.validuntil}</li>
                    </ul>

                    </td>

                    <td class="hidden-sm hidden-xs">{$quote.subject}</td>
                    <td class="hidden-sm hidden-xs"><span class="hidden">{$quote.normalisedDateCreated}</span>{$quote.datecreated}</td>
                    <td class="hidden-xs"><span class="hidden">{$quote.normalisedValidUntil}</span>{$quote.validuntil}</td>
                    <td><span class="label status status-{$quote.stageClass}">{$quote.stage}</span></td>
                    <td class="text-right">
                        <form method="submit" action="dl.php">
                            <input type="hidden" name="type" value="q" />
                            <input type="hidden" name="id" value="{$quote.id}" />
                            <input type="button" class="btn btn-link" value="{$LANG.quoteview}" onclick="window.location='viewquote.php?id={$quote.id}'" /> <button type="submit" class="btn btn-link"><i class="fa fa-download"></i> {$LANG.quotedownload}</button>
                        </form>
                    </td>
                    <td class="responsive-edit-button" style="display: none;">
                        <a href="viewquote.php?id={$quote.id}" class="btn btn-block btn-info">
                            {$LANG.manageproduct}
                        </a>
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
