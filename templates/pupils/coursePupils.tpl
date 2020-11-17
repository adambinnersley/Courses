{strip}
{assign var="headerSection" value="Course Pupils" scope="global"}
{assign var="title" value=$headerSection scope="global"}
{if isset($pagination)}
    {$pagination}
{/if}
<div class="mb-3">
<form method="post" action="/student/learning/{$courseInfo.url}/pupils/" class="form-horizontal form-inline">
    <div class="input-group mx-auto">
    <input name="search" type="text" size="40" value="{$search}" class="form-control" /><span class="input-group-append"><input type="submit" value="Search" class="btn btn-danger btn-sm" /></span>
    </div>
</form>
</div>
<div class="card border-primary">
    <div class="card-header bg-primary">Course Pupils</div>
    {if is_array($pupils) && !empty($pupils)}
        <table class="table table-hover table-striped mb-0">
        {foreach $pupils as $pupil}
            <tr>
                <td>{$pupil.name}</td>
                <td class="d-none d-lg-table-cell">{$pupil.email}</td>
                <td class="text-right"><a href="/student/learning/{$courseInfo.url}/pupils/{$pupil.id}-{$pupil.is_instructor}/edit" title="Edit Pupil" class="btn btn-warning btn-sm">Edit</a> <a href="/student/learning/{$courseInfo.url}/pupils/{$pupil.id}-{$pupil.is_instructor}/delete" title="Remove from course" class="btn btn-danger btn-sm"><span class="fas fa-trash"></span></a></td>
            </tr>
        {/foreach}
        </table>
    {else}
    <div class="card-body text-center text-bold">
        There are currently no pupils{if $search} matching the criteria{/if} assigned to this course
    </div>
    {/if}
</div>
{if isset($pagination)}
    {$pagination}
{/if}
{/strip}