{strip}
<div class="row">
    <div class="col-lg-6 mx-auto">
        <div class="card border-danger">
            <div class="card-header bg-danger">Delete Page</div>
            <div class="card-body">
                <h4>Confirm Page Delete</h4>
                <p>Are you sure you wish to delete the <strong>{$item.title}</strong> page?</p>
                <form method="post" action="" class="text-center">
                    <a href="/student/learning/{$courseInfo.url}/info/" title="No, return to page list" class="btn btn-success">No, return to page list</a> &nbsp; 
                    <input type="submit" name="confirmdelete" id="confirmdelete" class="btn btn-danger" value="Yes, delete page" />
                </form>
            </div>
        </div>
    </div>
</div>
{/strip}