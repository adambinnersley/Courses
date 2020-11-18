{strip}
<div class="row">
    <div class="col-lg-6 mx-auto">
        <div class="card border-danger">
            <div class="card-header bg-danger font-weight-bold">Remove pupil from this course?</div>
            <div class="card-body">
                <h4 class="text-center">Confirm Pupil Removal</h4>
                <p class="text-center">Are you sure you wish to remove the pupil <strong>{if $pupil.name}{$pupil.name}{else}{$pupil.firstname} {$pupil.lastname}{/if}</strong> from this course?</p>
                <form method="post" action="" class="text-center">
                    <a href="/student/learning/{$courseInfo.url}/pupils/" title="No, return to pupil list" class="btn btn-success">No, return to pupil list</a> &nbsp; 
                    <input type="submit" name="confirmdelete" id="confirmdelete" class="btn btn-danger" value="Yes, remove pupil" />
                </form>
            </div>
        </div>
    </div>
</div>
{/strip}