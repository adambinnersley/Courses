{strip}
<div class="row">
    <div class="col-12">
        <h3 class="text-center">Confirm Delete</h3>
        <p class="text-center">Are you sure you wish to delete the <strong>{$item.link_text} <small>({$item.file})</small></strong> document?</p>
        <div class="text-center">
        <form method="post" action="" class="form-inline">
            <a href="/student/learning/{$courseInfo.url}/course-documents/" title="No, return to documents" class="btn btn-success">No, return to documents</a> &nbsp; 
            <input type="submit" name="confirmdelete" id="confirmdelete" class="btn btn-danger" value="Yes, delete document" />
        </form>
        </div>
    </div>
</div>
{/strip}