{strip}
{assign var="headerSection" value="Reading List" scope="global"}
{include file="assets/page-header.tpl"}
{if $add || $edit || $delete}
    {assign var="backURL" value="reading-list/" scope="global"}
    {assign var="backText" value="Back to Reading List" scope="global"}
{/if}
{include file="assets/back-button.tpl"}
<div class="row">
    {if !$add && !$edit && !$delete}
        {if $userDetails.isHeadOffice}<div class="col-12"><a href="/student/learning/{$courseInfo.url}/reading-list/addnew" title="Add new item" class="btn btn-success float-right"><span class="fa fa-plus fa-fw"></span> Add new item</a></div>{/if}
     {include file="reading/readingList.tpl"}
</div>
    {elseif !$delete}
        {include file="reading/addReadingItem.tpl"}
    {else}
        {include file="reading/deleteReadingItem.tpl"}
    {/if}
</div>
{include file="assets/back-button.tpl"}
{/strip}