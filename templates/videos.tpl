{strip}
{assign var="headerSection" value="Videos" scope="global"}
{include file="assets/page-header.tpl"}
{if $add || $edit || $delete}
    {assign var="backURL" value="videos/" scope="global"}
    {assign var="backText" value="Back to Videos" scope="global"}
{/if}
{include file="assets/back-button.tpl"}
{if $userDetails.isHeadOffice && !$add && !$delete}
    <div class="row">
        <div class="col-12"><a href="/student/learning/{$courseInfo.url}/videos/add" title="Add new item" class="btn btn-success float-right"><span class="fa fa-plus fa-fw"></span> Add new video</a></div>
    </div>
{/if}
<div class="row">
    <div class="col-12">
    
    {include file="videos/listVideos.tpl"}
    </div>
</div>
{assign var="footerBtn" value="true" scope="global"}
{include file="assets/back-button.tpl"}
{/strip}