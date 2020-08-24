{strip}
<h3 class="text-center">Confirm Delete</h3>
<p class="text-center">Are you sure you wish to delete the {if $smarty.get.questionid}question{else}<strong>{$item.title}</strong> test{/if}?</p>
<div class="text-center">
    <form method="post" action="" class="form-inline">
        <a href="/student/learning/{$courseInfo.url}/tests/" title="No, return to test{if !$smarty.get.questionid}s{/if}" class="btn btn-success">No, return to test{if !$smarty.get.questionid}s{/if}</a> &nbsp; 
        <input type="submit" name="confirmdelete" id="confirmdelete" class="btn btn-danger" value="Yes, delete {if !$smarty.get.questionid}test{else}question{/if}" />
    </form>
</div>
{/strip}