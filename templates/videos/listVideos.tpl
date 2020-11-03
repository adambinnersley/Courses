{strip}
<div class="list-group">
{foreach $videos as $video}
    <a href="https://www.youtube.com/watch?v={$video.information->id}" class="list-group-item list-group-item-action flex-column align-items-start active">{if $userDetails.isHeadOffice}<div class="row"><div class="float-right"><a href="/student/learning/{$courseInfo.url}/videos/edit/{$item.id}" title="Edit item" class="btn btn-warning"><span class="fa fa-pencil-alt fa-fw"></span> Edit</a> <a href="/student/learning/{$courseInfo.url}/videos/delete/{$item.id}" title="Delete item" class="btn btn-danger"><span class="fa fa-trash fa-fw"></span> Delete</a></div></div>{/if}
        <img src="{$video.information->snippet->thumbnails->medium->url}" title="{$video.information->snippet->title}" class="img-fluid float-right" />
        <div class="d-flex justify-content-between">
        <h5 class="mb-1">{$video.information->snippet->title}</h5>
        </div>
        <p class="mb-1">{$video.description}</p>
    </a>
{/foreach}
</div>
{/strip}