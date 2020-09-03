{strip}
<div class="row">
    <div class="col-lg-6">
        <div class="card border-primary">
            <div class="card-header bg-primary"><span class="fas fa-film"></span> Add Video</div>
            <div class="card-body pb-0">
                <form method="post" action="" class="form-horizontal">
                    <div class="form-group row">
                        <label for="url" class="col-md-3 control-label">YouTube URL: <span class="text-danger">*</span></label>
                        <div class="col-md-9"><input name="url" id="url" type="text" size="100" class="form-control" placeholder="URL" value="{if $smarty.post.url}{$smarty.post.url}{else}{$item.url}{/if}" /></div>
                    </div>
                    <div class="form-group row{if $msgerror && !$smarty.post.video.title} has-error{/if}">
                        <label for="title" class="col-md-3 control-label">Title: <span class="text-danger">*</span></label>
                        <div class="col-md-9"><input name="video[title]" id="title" type="text" size="250" class="form-control" placeholder="Title" value="{if $smarty.post.video.title}{$smarty.post.video.title}{else}{$item.title}{/if}" /></div>
                    </div>
                    <div class="form-group row">
                        <label for="description" class="col-md-3 control-label">Description:</label>
                        <div class="col-md-9"><textarea name="video[description]" id="description" class="form-control" placeholder="Description">{if $smarty.post.video.description}{$smarty.post.video.description}{else}{$item.description}{/if}</textarea></div>
                    </div>
                    <div class="form-group row text-center">
                        <input name="submit" id="submit" type="submit" class="btn btn-success mx-auto" value="{if $edit}Edit{else}Add{/if} Video" />
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
{/strip}