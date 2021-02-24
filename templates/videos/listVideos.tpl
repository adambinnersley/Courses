{strip}
{assign var="headerSection" value="Videos" scope="global"}
{include file="assets/page-header.tpl"}
{if $userDetails.isHeadOffice}
    <div class="row">
        <div class="col-12"><a href="/student/learning/{$courseInfo.url}/videos/add" title="Add new item" class="btn btn-success float-right"><span class="fa fa-plus fa-fw"></span> Add new video</a></div>
    </div>
{/if}
{include file="assets/back-button.tpl"}
{assign var="title" value=$headerSection scope="global"}
<div class="row">
    <div class="col-12">
        {if is_array($videos)}
        <div class="list-group">
        {foreach $videos as $video}
            <{if $userDetails.isHeadOffice}div{else}a href="https://www.youtube.com/watch?v={$video.information->id}"{/if} class="list-group-item list-group-item-action flex-column align-items-start">
                {if $userDetails.isHeadOffice}<div class="row mb-1"><div class="col text-right"><a href="/student/learning/{$courseInfo.url}/videos/edit/{$video.id}" title="Edit item" class="btn btn-warning"><span class="fa fa-pencil-alt fa-fw"></span> Edit</a> <a href="/student/learning/{$courseInfo.url}/videos/delete/{$video.id}" title="Delete item" class="btn btn-danger"><span class="fa fa-trash fa-fw"></span> Delete</a></div></div>{/if}
                <img src="{$video.information->snippet->thumbnails->medium->url}" title="{$video.information->snippet->title}" class="img-fluid float-right" />
                <div class="d-flex justify-content-between">
                <h5 class="mb-1">{$video.information->snippet->title}</h5>
                </div>
                <p class="mb-1">{$video.description}</p>

            </{if $userDetails.isHeadOffice}div{else}a{/if}>
        {/foreach}
        </div>
        {else}
        <div class="row">
            <div class="col text-center text-bold">
                There are currently no videos in this course
            </div>
        </div>
        {/if}
    </div>
</div>
{assign var="footerBtn" value="true" scope="global"}
{include file="assets/back-button.tpl"}
{/strip}