{strip}
{assign var="headerSection" value="Videos" scope="global"}
{include file="assets/page-header.tpl"}
{if $add || $edit || $delete}
    {assign var="backURL" value="videos/" scope="global"}
    {assign var="backText" value="Back to Videos" scope="global"}
{/if}
{include file="assets/back-button.tpl"}
<div class="row">
    <div class="col-12">
    {if $userDetails.isHeadOffice && !$add && !$delete}<a href="/student/learning/{$courseInfo.url}/videos/add" title="Add new item" class="btn btn-success float-right"><span class="fa fa-plus fa-fw"></span> Add new video</a>{/if}
    {include file="videos/listVideos.tpl"}
    </div>
</div>
{include file="assets/back-button.tpl"}
{/strip}