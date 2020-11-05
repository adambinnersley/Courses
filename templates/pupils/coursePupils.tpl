{strip}
{if isset($pagination)}
    {$pagination}
{/if}
<div class="card border-primary">
    <div class="card-header bg-primary"></div>
    {if is_array($pupils)}
        <table class="table table-hover table-striped mb-0">
        {foreach $pupils as $pupil}
            <tr>
                <td>{$pupil.name}</td>
                <td>{$pupil.email}</td>
                <td><a href="#" title="Edit Pupil" class="btn btn-warning">Edit</a> <a href="#" title="Remove from course" class="btn btn-danger">Remove</a></td>
            </tr>
        {/foreach}
        </table>
    {else}
    <div class="card-body text-center text-bold">
        There are currently no pupils assigned to this course
    </div>
    {/if}
</div>
{if isset($pagination)}
    {$pagination}
{/if}
{/strip}