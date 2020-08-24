{strip}
{assign var="headerSection" value="Course Pupils" scope="global"}
{include file="assets/page-header.tpl"}
{if $add || $edit || $delete}
    {assign var="backURL" value="pupils/" scope="global"}
    {assign var="backText" value="Back to Pupils" scope="global"}
{/if}
{include file="assets/back-button.tpl"}
<div class="row">
    {if $userDetails.isHeadOffice && !$add && !$delete}<div class="col-12"><a href="/student/learning/{$courseInfo.url}/pupils/add" title="Add new pupil" class="btn btn-success float-right"><span class="fa fa-plus fa-fw"></span> Add new pupil</a></div>{/if}
    {include file="pupils/listPupils.tpl"}
</div>
{include file="assets/back-button.tpl"}
{/strip}