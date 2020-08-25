{strip}
<div class="card text-center">
    <div class="card-header h3">Confirm course delete</div>
    <div class="card-body">
    <p>Are you sure you want to delete the course "<strong>{$courseInfo.name}</strong>"?</p>
    <form action="" method="post" class="form-horizontal text-center">
        <a onclick="window.history.back()" title="No" class="btn btn-success">No</a>
        <input type="hidden" value="{$courseInfo.id}" name="courseid" />&nbsp; &nbsp;
        <input type="submit" value="Yes" name="confirm" id="confirm" class="btn btn-danger" />
    </form>
    </div>
</div>
{/strip}