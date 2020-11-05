{strip}
<div class="card border-primary">
    <div class="card-header bg-primary"></div>
    <div class="card-body">
        {if is_array($pupils)}
            <table class="table table-hover table-striped">
            {foreach $pupils as $pupil}
                <tr>
                    <td>{$pupil.firstname} {$pupil.lastname}</td>
                </tr>
            {/foreach}
            </table>
        {else}
            There are currently no pupils assigned to this course
        {/if}
    </div>
</div>
{/strip}