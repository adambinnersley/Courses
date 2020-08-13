{strip}
<div class="row" id="course-list">
    <div class="col-12">
        <h1 class="page-header"><span class="page-header-text"><span class="fa fa-graduation-cap"></span> {$courseInfo.name} <small>/ Videos</small></span></h1>
    </div>
    <div class="col-12">
        <a href="{if !$add && !$edit && !$delete}./{else}videos/{/if}" title="Back to {if !$add && !$edit && !$delete}course home{else}videos{/if}" class="btn btn-default">&laquo; Back to {if !$add && !$edit && !$delete}course home{else}videos{/if}</a>
    </div>
    <div class="col-12">
    {if $smarty.get.itemdeleted}<div class="alert alert-success">The video has successfully been removed from the course</div>{/if}
    {if $userDetails.isHeadOffice && !$add && !$delete}<a href="videos/add" title="Add new item" class="btn btn-success float-right"><span class="fa fa-plus fa-fw"></span> Add new video</a>{/if}
    {if $add || $edit}
        <form method="post" action="" class="form-horizontal">
            <div class="form-group form-inline">
                <label for="url" class="col-md-3 control-label">YouTube URL: <span class="text-danger">*</span></label>
                <div class="col-md-9"><input name="url" id="url" type="text" size="100" class="form-control" placeholder="URL" value="{if $smarty.post.url}{$smarty.post.url}{else}{$item.url}{/if}" /></div>
            </div>
            <div class="form-group{if $msgerror && !$smarty.post.video.title} has-error{/if}">
                <label for="title" class="col-md-3 control-label">Title: <span class="text-danger">*</span></label>
                <div class="col-md-8"><input name="video[title]" id="title" type="text" size="250" class="form-control" placeholder="Title" value="{if $smarty.post.video.title}{$smarty.post.video.title}{else}{$item.title}{/if}" /></div>
            </div>
            <div class="form-group">
                <label for="description" class="col-md-3 control-label">Description:</label>
                <div class="col-md-8"><textarea name="video[description]" id="description" class="form-control" placeholder="Description">{if $smarty.post.video.description}{$smarty.post.video.description}{else}{$item.description}{/if}</textarea></div>
            </div>
            <div class="form-group text-center">
                <input name="submit" id="submit" type="submit" class="btn btn-success" value="{if $edit}Edit{else}Add{/if} Video" />
            </div>
        </form>
    {elseif $delete}
        <h3 class="text-center">Confirm Delete</h3>
        <p class="text-center">Are you sure you wish to delete the <strong>{$item.title}</strong> video?</p>
        <div class="text-center">
        <form method="post" action="" class="form-inline">
            <a href="videos/" title="No, return to reading list" class="btn btn-success">No, return to videos</a> &nbsp; 
            <input type="submit" name="confirmdelete" id="confirmdelete" class="btn btn-danger" value="Yes, delete video" />
        </form>
        </div>
    {else}
        {foreach $videos as $video}
            {$video.information->snippet->thumbnails->standard->url}
            <pre>
            {$video.information|print_r}
            </pre>
        {/foreach}
    {/if}
    </div>
    <div class="col-12">
        <a href="{if !$add && !$edit && !$delete}./{else}videos/{/if}" title="Back to {if !$add && !$edit && !$delete}course home{else}videos{/if}" class="btn btn-default">&laquo; Back to {if !$add && !$edit && !$delete}course home{else}videos{/if}</a>
    </div>
</div>
{/strip}