{strip}
{assign var="title" value="Delete Document" scope="global"}
<div class="row">
    <div class="col-lg-6 mx-auto">
        <div class="card border-danger">
            <div class="card-header bg-danger font-weight-bold">Delete Document?</div>
            <div class="card-body">
                <h4>Confirm Delete</h4>
                <p>Are you sure you wish to delete the <strong>{$item.link_text} <small>({$item.file})</small></strong> document?</p>
                <form method="post" action="" class="text-center">
                    <a href="/student/learning/{$courseInfo.url}/course-documents/" title="No, return to documents" class="btn btn-success">No, return to documents</a> &nbsp; 
                    <input type="submit" name="confirmdelete" id="confirmdelete" class="btn btn-danger" value="Yes, delete document" />
                </form>
            </div>
        </div>
    </div>
</div>
{/strip}