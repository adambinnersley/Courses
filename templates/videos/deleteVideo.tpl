{strip}
<div class="row">
    <div class="col-lg-6 mx-auto">
        <div class="card border-danger">
            <div class="card-header bg-danger">Confirm Video Delete</div>
            <div class="card-body">
                <h4>Confirm Delete</h4>
                <p>Are you sure you wish to delete the <strong>{$item.title}</strong> video?</p>
                <form method="post" action="" class="text-center">
                    <a href="/student/learning/{$courseInfo.url}/videos/" title="No, return to videos" class="btn btn-success">No, return to videos</a> &nbsp; 
                    <input type="submit" name="confirmdelete" id="confirmdelete" class="btn btn-danger" value="Yes, delete video" />
                </form>
            </div>
        </div>
    </div>
</div>
{/strip}