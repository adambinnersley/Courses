{strip}
<div class="card border-primary">
    <div class="card-header bg-primary">{if $addCourse}Add{else}Edit{/if} Page</div>
    <div class="card-body">
        <form method="post" action="" class="form-horizontal">
            <div class="form-group">
                <label for="name" class="col-md-2 control-label">Name:</label>
                <div class="col-md-10"><input type="text" name="name" id="name" class="form-control" value="{if $addCourse}{$smarty.post.name}{else}{$courseInfo.name}{/if}" /></div>
            </div>
            <div class="form-group">
                <label for="url" class="col-md-2 control-label">URL:</label>
                <div class="col-md-10"><input type="text" name="url" id="url" class="form-control" value="{if $addCourse}{$smarty.post.url}{else}{$courseInfo.url}{/if}" /></div>
            </div>
            <div class="form-group">
                <label for="description" class="col-md-2 control-label">Description:</label>
                <div class="col-md-10"><textarea name="description" id="description" class="form-control" rows="20">{if $addCourse}{$smarty.post.description}{else}{$courseInfo.description}{/if}</textarea></div>
            </div>
            <div class="form-group">
                <label for="name" class="col-md-2 control-label">Status:</label>
                <div class="col-md-10">
                    <select name="active" id="active" class="form-control">
                        <option value="0"{if !$addCourse && $courseInfo.active != 1} selected="selected"{/if}>Disabled</option>
                        <option value="1"{if $addCourse || $courseInfo.active == 1} selected="selected"{/if}>Active</option>
                    </select>
                </div>
            </div>
            <div class="text-center"><input type="submit" name="submit" id="submit" value="{if $addCourse}Add{else}Edit{/if} Page" class="btn btn-success btn-lg" /></div>
        </form>
    </div>
</div>
{/strip}