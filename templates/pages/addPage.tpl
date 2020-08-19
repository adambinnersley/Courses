{strip}
<form method="post" action="" class="form-horizontal">
    <div class="form-group">
        <label for="title" class="col-md-2 control-label">Title:</label>
        <div class="col-md-10"><input type="text" name="title" id="title" class="form-control" value="{$smarty.post.title}" /></div>
    </div>
    {if $subpages}<div class="form-group">
        <label for="subpage" class="col-md-2 control-label">Subpage of:</label>
        <div class="col-md-10">
            <select name="subpage" id="subpage" class="form-control">
                <option value="0">None</option>
                <optgroup label="Select Page">
                {foreach $subpages as $page}
                    <option value="{$page.page_id}"{if $smarty.post.subpage == $page.page_id} selected="selected"{/if}>{$page.order}) {$page.title}</option>
                {/foreach}
                </optgroup>
            </select>
        </div>
    </div>{/if}
    <div class="form-group">
        <label for="content" class="col-md-2 control-label">Content:</label>
        <div class="col-md-10"><textarea name="content" id="content" class="form-control" rows="20">{$smarty.post.content}</textarea></div>
    </div>
    <div class="text-center"><input type="submit" name="submit" id="submit" value="Add Page" class="btn btn-success btn-lg" /></div>
</form>
{/strip}