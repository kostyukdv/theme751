{if $languagechangeenabled && count($locales) > 1}
<div class="visible-xs-block">
  <div class="col-md-4 col-md-offset-4">
    <div class="btn-group">
      <button type="button" class="btn btn-primary btn-sm btn-block dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        {$LANG.chooselanguage}  <span class="caret"></span>
      </button>
      <ul class="dropdown-menu">
        {foreach from=$locales item=locale}
        {if $LANG.chooselanguage == $locale.localisedName}
        <li><a class="active" href="{$currentpagelinkback}language={$locale.language}"  data-lang="{$locale.language}">{$locale.localisedName}</a></li>
        {else}
        <li><a href="{$currentpagelinkback}language={$locale.language}"  data-lang="{$locale.language}" >{$locale.localisedName}</a></li>
        {/if}
        {/foreach}
      </ul>
    </div>
  </div>
</div>
{/if}
