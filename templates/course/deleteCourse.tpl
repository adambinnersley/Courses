{strip}
<div class="row">
    <div class="col-lg-6 mx-auto">
        <div class="card border-danger">
            <div class="card-header bg-danger">Confirm course delete?</div>
            <div class="card-body">
                <h4>Confirm Page Delete</h4>
                <p>Are you sure you want to delete the course "<strong>{$courseInfo.name}</strong>"?</p>
                <form method="post" action="" class="text-center">
                    <a onclick="window.history.back()" title="No" class="btn btn-success">No</a>
                    <input type="hidden" value="{$courseInfo.id}" name="courseid" />&nbsp; &nbsp;
                    <input type="submit" value="Yes" name="confirm" id="confirm" class="btn btn-danger" />
                </form>
            </div>
        </div>
    </div>
</div>
{/strip}