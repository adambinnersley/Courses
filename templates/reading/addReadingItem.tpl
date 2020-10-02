{strip}
<div class="card border-primary">
    <div class="card-header bg-primary">Add Reading List Item</div>
    <div class="card-body">
        <form method="post" action="" class="form-horizontal">
            <div class="form-group row form-inline">
                <label for="type" class="col-md-3 control-label">Type: <span class="text-danger">*</span></label>
                <div class="col-md-9"><select name="type" id="type" class="form-control"><option value="1"{if $smarty.post.type == 1 || (!$smarty.post.type && (!$item.resource_type || $item.resource_type == 1))} selected="selected"{/if}>Book</option><option value="2"{if $smarty.post.type == 2 || (!$smarty.post.type && $item.resource_type == 2)} selected="selected"{/if}>Link</option></select></div>
            </div>
            <div class="form-group row{if $msgerror && !$smarty.post.title} has-error{/if}">
                <label for="title" class="col-md-3 control-label">Title: <span class="text-danger">*</span></label>
                <div class="col-md-8"><input name="title" id="title" type="text" size="250" class="form-control" placeholder="Title" value="{if $smarty.post.title}{$smarty.post.title}{else}{$item.title}{/if}" /></div>
            </div>
            <div class="form-group row">
                <label for="description" class="col-md-3 control-label">Description:</label>
                <div class="col-md-8"><textarea name="description" id="description" class="form-control" placeholder="Description">{if $smarty.post.description}{$smarty.post.description}{else}{$item.description}{/if}</textarea></div>
            </div>
            <div id="book-elements"{if $smarty.post.type == 2 || (!$smarty.post.type && $item.resource_type == 2)} style="display:none"{/if}>
                <div class="form-group row">
                    <label for="author" class="col-md-3 control-label">Author:</label>
                    <div class="col-md-8"><input name="author" id="author" type="text" size="100" class="form-control" placeholder="Author" value="{if $smarty.post.author}{$smarty.post.author}{else}{$item.author}{/if}" /></div>
                </div>
                <div class="form-group row">
                    <label for="publisher" class="col-md-3 control-label">Publisher:</label>
                    <div class="col-md-8"><input name="publisher" id="publisher" type="text" size="100" class="form-control" placeholder="Publisher" value="{if $smarty.post.publisher}{$smarty.post.publisher}{else}{$item.publisher}{/if}" /></div>
                </div>
                <div class="form-group row form-inline">
                    <label for="publishdate" class="col-md-3 control-label">Publish Date:</label>
                    <div class="col-md-8"><input name="publishdate" id="publishdate" type="text" size="20" class="form-control" placeholder="Publish Date" value="{if $smarty.post.publishdate}{$smarty.post.publishdate}{else}{$item.publish_date}{/if}" /></div>
                </div>
                <div class="form-group row form-inline{if $msgerror && $smarty.post.type == 1 && !$smarty.post.isbn} has-error{/if}">
                    <label for="isbn" class="col-md-3 control-label">ISBN: <span class="text-danger">*</span></label>
                    <div class="col-md-8"><input name="isbn" id="isbn" type="text" size="40" class="form-control" placeholder="ISBN" value="{if $smarty.post.isbn}{$smarty.post.isbn}{else}{$item.isbn}{/if}" /></div>
                </div>
            </div>
            <div class="form-group row{if $msgerror && $smarty.post.type == 2 && !$smarty.post.link} has-error{/if}">
                <label for="link" class="col-md-3 control-label">URL: <span class="text-danger require-link"{if $smarty.post.type == 1 || (!$smarty.post.type && (!$item.resource_type || $item.resource_type == 1))} style="display:none"{/if}>*</span></label>
                <div class="col-md-8"><input name="link" id="link" type="text" size="250" class="form-control" placeholder="Link URL" value="{if $smarty.post.link}{$smarty.post.link}{else}{$item.link}{/if}" /></div>
            </div>
            <div class="form-group row text-center">
                <input name="submit" id="submit" type="submit" class="btn btn-success" value="{if $edit}Edit{else}Add{/if} Reading List Item" />
            </div>
        </form>
        <script type="text/javascript">
            {literal}$('#type').change(function(){if($(this).val() != 1){$('#book-elements').hide();$('.require-link').show();}else{$('#book-elements').show();$('.require-link').hide();}});{/literal}
        </script>
    </div>
</div>
{/strip}