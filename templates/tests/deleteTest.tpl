{strip}
<div class="row">
    <div class="col-lg-6 mx-auto">
        <div class="card border-danger">
            <div class="card-header bg-danger font-weight-bold">Confirm Delete</div>
            <div class="card-body">
                <h4>Confirm Delete</h4>
                <p>Are you sure you wish to delete the {if $smarty.get.questionid}question{else}<strong>{$item.title}</strong> test{/if}?</p>
                <form method="post" action="" class="text-center">
                    <a href="/student/learning/{$courseInfo.url}/tests/" title="No, return to test{if !$smarty.get.questionid}s{/if}" class="btn btn-success">No, return to test{if !$smarty.get.questionid}s{/if}</a> &nbsp; 
                    <input type="submit" name="confirmdelete" id="confirmdelete" class="btn btn-danger" value="Yes, delete {if !$smarty.get.questionid}test{else}question{/if}" />
                </form>
            </div>
        </div>
    </div>
</div>
{/strip}