{strip}
<div class="card border-danger" id="deletegroup">
    <div class="card-header">Delete Group</div>
    <div class="card-body">
        <h4 class="text-center">Confirm Delete</h4>
        <p class="text-center">Are you sure that you want to delete the <strong>{$group.name}</strong> group?</p>
        <div class="text-center">
            <form method="post" action="" class="form-inline">
                <a href="/student/learning/{$courseInfo.url}/course-documents/" title="No, leave it as is" class="btn btn-success">No, leave it as is</a> &nbsp; 
                <input type="submit" name="confirmdelete" id="confirmdelete" class="btn btn-danger" value="Yes, delete document group" />
            </form>
        </div>
    </div>
</div>
{/strip}