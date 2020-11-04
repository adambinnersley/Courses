{strip}
<div class="row">
    <div class="col-lg-6 mx-auto">
        <div class="card border-danger" id="deletegroup">
            <div class="card-header bg-danger">Delete Group?</div>
            <div class="card-body">
                <h4>Confirm Delete</h4>
                <p>Are you sure that you want to delete the <strong>{$group.name}</strong> group?</p>
                <form method="post" action="" class="text-center">
                    <a href="/student/learning/{$courseInfo.url}/course-documents/groups/" title="No, leave it as is" class="btn btn-success">No, leave it as is</a> &nbsp; 
                    <input type="submit" name="confirmdelete" id="confirmdelete" class="btn btn-danger" value="Yes, delete document group" />
                </form>
            </div>
        </div>
    </div>
</div>
{/strip}