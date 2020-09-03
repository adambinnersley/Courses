{strip}
<div class="card border-danger">
    <div class="card-header">Delete Page</div>
    <div class="card-body">
        <h4 class="text-center">Confirm Page Delete</h4>
        <p class="text-center">Are you sure you wish to delete the <strong>{$item.title}</strong> page?</p>
        <div class="text-center">
            <form method="post" action="" class="form-inline">
                <a href="/student/learning/{$courseInfo.url}/info/" title="No, return to page list" class="btn btn-success">No, return to page list</a> &nbsp; 
                <input type="submit" name="confirmdelete" id="confirmdelete" class="btn btn-danger" value="Yes, delete page" />
            </form>
        </div>
    </div>
</div>
{/strip}