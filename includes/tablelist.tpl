<link rel="stylesheet" type="text/css" href="{$BASE_PATH_CSS}/dataTables.bootstrap.css">
<script type="text/javascript" charset="utf8" src="{$BASE_PATH_JS}/jquery.dataTables.min.js"></script>
<script type="text/javascript" charset="utf8" src="{$BASE_PATH_JS}/dataTables.bootstrap.min.js"></script>

<script type="text/javascript">
jQuery(document).ready( function () {ldelim}
    var table = jQuery("#table{$tableName}").DataTable({ldelim}
        "dom": '<"listtable"fit>pl',{if isset($noPagination) && $noPagination}
        "paging": false,{/if}{if isset($noInfo) && $noInfo}
        "info": false,{/if}{if isset($noSearch) && $noSearch}
        "filter": false,{/if}
        "bInfo": false,
        "oLanguage": {ldelim}
            "sEmptyTable":     "{$LANG.norecordsfound}",
            "sInfo":           "{$LANG.tableshowing}",
            "sInfoEmpty":      "{$LANG.tableempty}",
            "sInfoFiltered":   "{$LANG.tablefiltered}",
            "sInfoPostFix":    "",
            "sInfoThousands":  ",",
            "sLengthMenu":     "{$LANG.tablelength}",
            "sLoadingRecords": "{$LANG.tableloading}",
            "sProcessing":     "{$LANG.tableprocessing}",
            "sSearch":         "",
            "sZeroRecords":    "{$LANG.norecordsfound}",
            "oPaginate": {ldelim}
                "sFirst":    "{$LANG.tablepagesfirst}",
                "sLast":     "{$LANG.tablepageslast}",
                "sNext":     "{$LANG.tablepagesnext}",
                "sPrevious": "{$LANG.tablepagesprevious}"
            {rdelim}
        {rdelim},
        "pageLength": 10,
        "order": [
            [ {if isset($startOrderCol) && $startOrderCol}{$startOrderCol}{else}0{/if}, "asc" ]
        ],
        "lengthMenu": [
            [10, 25, 50, -1],
            [10, 25, 50, "{$LANG.tableviewall}"]
        ],
        "aoColumnDefs": [
            {ldelim}
                "bSortable": false,
                "aTargets": [ {if isset($noSortColumns) && $noSortColumns !== ''}{$noSortColumns}{/if} ]
            {rdelim},
            {ldelim}
                "sType": "string",
                "aTargets": [ {if isset($filterColumn) && $filterColumn}{$filterColumn}{/if} ]
            {rdelim}
        ],
        "stateSave": true
    {rdelim});
    jQuery(".dataTables_filter input").attr("placeholder", "{$LANG.tableentersearchterm}");

    {if isset($filterColumn) && isset($filterColumn)}
    // highlight remembered filter on page re-load
    var rememberedFilterTerm = table.state().columns[{$filterColumn}].search.search;
    if (rememberedFilterTerm) {
        jQuery(".view-filter-btns a span").each(function(index) {
            if (jQuery(this).text().trim() == rememberedFilterTerm) {
                jQuery(this).parent('a').addClass('active');
                jQuery(this).parent('a').find('i').addClass('fa-dot-circle-o').removeClass('fa-circle-o');
            }
        });
    }
    {/if}



jQuery( "<div class=\"panel-footer\">" ).insertAfter( jQuery("#table{$tableName}_wrapper .listtable") );

jQuery("<div class=\"clearfix\">").prependTo("#table{$tableName}_wrapper .panel-footer");
jQuery("#table{$tableName}_wrapper .dataTables_length").prependTo("#table{$tableName}_wrapper .panel-footer");
jQuery("#table{$tableName}_wrapper .dataTables_paginate").prependTo("#table{$tableName}_wrapper .panel-footer");

jQuery(jQuery('<div id='+"#table{$tableName}_tmp"+'>').append(jQuery("#table{$tableName}_wrapper .dataTables_filter").clone()).html())
            .insertAfter( jQuery("#table{$tableName}_wrapper").parents('div.panel').find(".elemetsholder")   );
jQuery("#table{$tableName}_wrapper .dataTables_filter").hide();
jQuery("#table{$tableName}_wrapper .dataTables_filter").attr('id',"table{$tableName}_filter_h");

jQuery("#table{$tableName}_filter_h input").attr('id',"table{$tableName}_filter_hi");

    var filter = document.getElementById("table{$tableName}_filter_hi");

    jQuery("#table{$tableName}_filter input").keyup(function() {ldelim}
        filter.value = this.value;
        jQuery(filter).change();
        jQuery(filter).keyup();
    {rdelim});

jQuery("#table{$tableName}_filter input").addClass('input_search');

{if isset($filterColumn) && isset($filterColumn)}



    jQuery(jQuery('<div id='+"#table{$tableName}_filter"+'>').append(jQuery('.filter_top').clone()).html()).insertAfter( "#table{$tableName}_info" );
    jQuery('.filter_top:last').show();

    jQuery(".view-filter-btns a").click(function() {ldelim}
    var filterValue = jQuery(this).find("span").html().trim();
    var dataTable = jQuery('#table{$tableName}').DataTable();
    if (jQuery(this).hasClass('active')) {ldelim}
        {if !isset($dontControlActiveClass) || !$dontControlActiveClass}
            jQuery(this).removeClass('active');
            jQuery(this).find(jQuery("i.fa.fa-dot-circle-o")).addClass('fa-circle-o').removeClass('fa-dot-circle-o');
        {/if}
        dataTable.column({$filterColumn}).search('').draw();
    {rdelim} else {ldelim}
        {if !isset($dontControlActiveClass) || !$dontControlActiveClass}
            jQuery('.view-filter-btns .list-group-item').removeClass('active');
            jQuery('.view-filter-btns a').removeClass('active');
            jQuery('i.fa.fa-dot-circle-o').addClass('fa-circle-o').removeClass('fa-dot-circle-o');
            jQuery(this).addClass('active');
            jQuery(this).find(jQuery("i.fa.fa-circle-o")).addClass('fa-dot-circle-o').removeClass('fa-circle-o');
        {/if}
        dataTable.column({$filterColumn}).search(filterValue, false, false, false).draw();
    {rdelim}
{rdelim});


{/if}


{rdelim} );

</script>
