{strip}
<div class="row">
    <div class="col-lg-6 mx-auto">
        <div class="card border-danger">
            <div class="card-header bg-danger">Delete Pupil?</div>
            <div class="card-body">
                <h4 class="text-center">Confirm Pupil Delete</h4>
                <p class="text-center">Are you sure you wish to delete the pupil <strong>{$pupil.name}</strong>?</p>
                <form method="post" action="" class="text-center">
                    <a href="/student/learning/{$courseInfo.url}/pupils/" title="No, return to pupil list" class="btn btn-success">No, return to pupil list</a> &nbsp; 
                    <input type="submit" name="confirmdelete" id="confirmdelete" class="btn btn-danger" value="Yes, delete pupil" />
                </form>
            </div>
        </div>
    </div>
</div>
{/strip}