{strip}
{assign var="title" value="Delete Reading List Item" scope="global"}
<div class="row">
    <div class="col-lg-6 mx-auto">
        <div class="card border-danger">
            <div class="card-header bg-danger font-weight-bold">Confirm Delete</div>
            <div class="card-body">
                <h4>Confirm Delete</h4>
                <p>Are you sure you wish to delete the <strong>{$item.title}</strong> item?</p>
                <form method="post" action="" class="text-center">
                    <a href="/student/learning/{$courseInfo.url}/reading-list/" title="No, return to reading list" class="btn btn-success">No, return to reading list</a> &nbsp; 
                    <input type="submit" name="confirmdelete" id="confirmdelete" class="btn btn-danger" value="Yes, delete item" />
                </form>
            </div>
        </div>
    </div>
</div>
{/strip}