{strip}
<div class="card">
    <div class="card-header">Add Document Group</div>
    <div class="card-body">
        <form method="post" action="" class="form-horizontal">
            <div class="form-group{if $error && !$smarty.post.group_name} has-error{/if}">
                <label for="group_name" class="col-md-3 control-label"><span class="text-danger">*</span> Name:</label>
                <div class="col-md-9"><input type="text" name="group_name" id="group_name" value="{$group_name}" size="9" placeholder="Document group name" class="form-control" /></div>
            </div>
            <div class="form-group">
                <div class="col-md-9 col-md-offset-3"><label class="sr-only" for="submitbtn">Submit</label><input name="submitbtn" id="submitbtn" class="btn btn-success" type="submit" value="Add Group" /></div>
            </div>
        </form>
    </div>
</div>
{/strip}