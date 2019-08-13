{strip}
<div class="row">
    <div class="col-12">
        <h1 class="page-header"><span class="page-header-text"><span class="fa fa-graduation-cap"></span> {$courseInfo.name} <small>/ Reading List</small></span></h1>
    </div>
</div>
<div class="row">
    <div class="col-12">
        <a href="{if !$add && !$edit && !$delete}./{else}reading-list{/if}" title="Back to {if !$add && !$edit && !$delete}course home{else}reading list{/if}"  class="btn btn-default">&laquo; Back to {if !$add && !$edit && !$delete}course home{else}reading list{/if}</a>
    </div>
</div>
<div class="row">
    {if !$add && !$edit && !$delete}
        {if $userDetails.isHeadOffice}<div class="col-12"><a href="reading-list?addnew=true" title="Add new item" class="btn btn-success float-right"><span class="fa fa-plus fa-fw"></span> Add new item</a></div>{/if}
        {if $readingList}
        {foreach $readingList as $item}
            {if !$readingtype}
            <div class="col-lg-6">
                {if $item.resource_type == 1}<h3>Books</h3>{elseif $item.resource_type == 2}<h3>Useful links</h3>{/if}
                <div class="list-group">
            {/if}
            {if $readingtype && ($readingtype != $item.resource_type)}
                    </div>
                </div>
                <div class="col-lg-6">
                    {if $item.resource_type == 1}<h3>Books</h3>{elseif $item.resource_type == 2}<h3>Useful links</h3>{/if}
                    <div class="list-group">
            {/if}
            {if $item.link && $item.resource_type == 2 && !$userDetails.isHeadOffice}<a href="{$item.link}" title="{$item.title}" target="_blank" class="list-group-item">{else}<div class="list-group-item">{/if}
                {if $userDetails.isHeadOffice}<div class="float-right"><a href="reading-list?edit={$item.id}" title="Edit item" class="btn btn-warning"><span class="fa fa-pencil fa-fw"></span> Edit</a> <a href="reading-list?delete={$item.id}" title="Delete item" class="btn btn-danger"><span class="fa fa-trash fa-fw"></span> Delete</a></div>{/if}
                <span class="fa fa-{if $item.resource_type == 1}book{elseif $item.resource_type == 2}link{/if} fa-fw"></span> {if $item.resource_type == 1}<strong>{/if}{$item.title}{if $item.resource_type == 1}</strong>{/if}
                {if $userDetails.isHeadOffice && $item.link && $item.resource_type == 2}<br /><small>{$item.link}</small>{/if}
                {if $item.description}<br /><small>{$item.description}</small>{/if}
                {if $item.resource_type == 1}
                    {if $item.author}<br /><small><strong>Author:</strong> {$item.author}</small>{/if}
                    {if $item.publisher}<br /><small><strong>Publisher:</strong> {$item.publisher}</small>{/if}
                    {if $item.publish_date}<br /><small><strong>Publish Date:</strong> {$item.publish_date}</small>{/if}
                    {if $item.isbn}<br /><small><strong>ISBN:</strong> {$item.isbn}</small>{/if}
                    {if $item.link}<br /><small><strong>Link:</strong> <a href="{$item.link}" title="{$item.title}">{$item.link}</a></small>{/if}
                {/if}
            {if $item.link && $item.resource_type == 2 && !$userDetails.isHeadOffice}</a>{else}</div>{/if}
            {assign var="readingtype" value=$item.resource_type}
        {/foreach}
            </div>
        </div>
        {/if}
    {elseif !$delete}
    <div class="col-12">
        <form method="post" action="" class="form-horizontal">
            <div class="form-group form-inline">
                <label for="type" class="col-md-3 control-label">Type: <span class="text-danger">*</span></label>
                <div class="col-md-9"><select name="type" id="type" class="form-control"><option value="1"{if $smarty.post.type == 1 || (!$smarty.post.type && (!$item.resource_type || $item.resource_type == 1))} selected="selected"{/if}>Book</option><option value="2"{if $smarty.post.type == 2 || (!$smarty.post.type && $item.resource_type == 2)} selected="selected"{/if}>Link</option></select></div>
            </div>
            <div class="form-group{if $msgerror && !$smarty.post.title} has-error{/if}">
                <label for="title" class="col-md-3 control-label">Title: <span class="text-danger">*</span></label>
                <div class="col-md-8"><input name="title" id="title" type="text" size="250" class="form-control" placeholder="Title" value="{if $smarty.post.title}{$smarty.post.title}{else}{$item.title}{/if}" /></div>
            </div>
            <div class="form-group">
                <label for="description" class="col-md-3 control-label">Description:</label>
                <div class="col-md-8"><textarea name="description" id="description" class="form-control" placeholder="Description">{if $smarty.post.description}{$smarty.post.description}{else}{$item.description}{/if}</textarea></div>
            </div>
            <div id="book-elements"{if $smarty.post.type == 2 || (!$smarty.post.type && $item.resource_type == 2)} style="display:none"{/if}>
                <div class="form-group">
                    <label for="author" class="col-md-3 control-label">Author:</label>
                    <div class="col-md-8"><input name="author" id="author" type="text" size="100" class="form-control" placeholder="Author" value="{if $smarty.post.author}{$smarty.post.author}{else}{$item.author}{/if}" /></div>
                </div>
                <div class="form-group">
                    <label for="publisher" class="col-md-3 control-label">Publisher:</label>
                    <div class="col-md-8"><input name="publisher" id="publisher" type="text" size="100" class="form-control" placeholder="Publisher" value="{if $smarty.post.publisher}{$smarty.post.publisher}{else}{$item.publisher}{/if}" /></div>
                </div>
                <div class="form-group form-inline">
                    <label for="publishdate" class="col-md-3 control-label">Publish Date:</label>
                    <div class="col-md-8"><input name="publishdate" id="publishdate" type="text" size="20" class="form-control" placeholder="Publish Date" value="{if $smarty.post.publishdate}{$smarty.post.publishdate}{else}{$item.publish_date}{/if}" /></div>
                </div>
                <div class="form-group form-inline{if $msgerror && $smarty.post.type == 1 && !$smarty.post.isbn} has-error{/if}">
                    <label for="isbn" class="col-md-3 control-label">ISBN: <span class="text-danger">*</span></label>
                    <div class="col-md-8"><input name="isbn" id="isbn" type="text" size="40" class="form-control" placeholder="ISBN" value="{if $smarty.post.isbn}{$smarty.post.isbn}{else}{$item.isbn}{/if}" /></div>
                </div>
            </div>
            <div class="form-group{if $msgerror && $smarty.post.type == 2 && !$smarty.post.link} has-error{/if}">
                <label for="link" class="col-md-3 control-label">URL: <span class="text-danger require-link"{if $smarty.post.type == 1 || (!$smarty.post.type && (!$item.resource_type || $item.resource_type == 1))} style="display:none"{/if}>*</span></label>
                <div class="col-md-8"><input name="link" id="link" type="text" size="250" class="form-control" placeholder="Link URL" value="{if $smarty.post.link}{$smarty.post.link}{else}{$item.link}{/if}" /></div>
            </div>
            <div class="form-group text-center">
                <input name="submit" id="submit" type="submit" class="btn btn-success" value="{if $edit}Edit{else}Add{/if} Reading List Item" />
            </div>
        </form>
        <script type="text/javascript">
            {literal}$('#type').change(function(){if($(this).val() != 1){$('#book-elements').hide();$('.require-link').show();}else{$('#book-elements').show();$('.require-link').hide();}});{/literal}
        </script>
    </div>
    {else}
        <h3 class="text-center">Confirm Delete</h3>
        <p class="text-center">Are you sure you wish to delete the <strong>{$item.title}</strong> item?</p>
        <div class="text-center">
        <form method="post" action="" class="form-inline">
            <a href="reading-list" title="No, return to reading list" class="btn btn-success">No, return to reading list</a> &nbsp; 
            <input type="submit" name="confirmdelete" id="confirmdelete" class="btn btn-danger" value="Yes, delete item" />
        </form>
        </div>
    {/if}
</div>
<div class="row">
    <div class="col-12">
        <a href="{if !$add && !$edit && !$delete}./{else}reading-list{/if}" title="Back to {if !$add && !$edit && !$delete}course home{else}reading list{/if}" class="btn btn-default">&laquo; Back to {if !$add && !$edit && !$delete}course home{else}reading list{/if}</a>
    </div>
</div>
{/strip}