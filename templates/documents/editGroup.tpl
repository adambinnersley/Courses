{strip}
<div class="card border-primary" id="editgroup">
    <div class="card-header bg-primary">{if $addGroup}Add Document{else}Edit{/if} Group</div>
    <div class="card-body">
        <form method="post" action="" class="form-horizontal">
            <div class="form-group row{if $error && !$smarty.post.group_name} has-error{/if}">
                <label for="edit_group_name" class="col-md-3 control-label"><span class="text-danger">*</span> Name:</label>
                <div class="col-md-9"><input type="text" name="edit_group_name" id="edit_group_name" value="{$groupinfo.name}" size="9" placeholder="Document group name" class="form-control" /></div>
            </div>
            <div class="form-group row">
                <div class="col-md-9 col-md-offset-3"><label class="sr-only" for="submitbtn">Submit</label><input id="submitbtn" class="btn btn-success" type="submit" value="{if $addGroup}Add{else}Edit{/if} Group" /></div>
            </div>
        </form>
    </div>
</div>
{/strip}