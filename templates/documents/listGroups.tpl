<div class="card">
    <div class="card-header">Document Groups</div>
    <ul class="list-group">
    {foreach $doc_groups as $group}
        <li class="list-group-item">{$group.name}<div class="float-right"><a href="/student/learning/{$courseInfo.url}/course-documents/edit/{$group.id}/#editgroup" title="Edit group" class="btn btn-warning btn-sm"><span class="fa fa-pencil-alt fa-fw"></span> Edit</a>{if $group.items == 0} <a href="/student/learning/{$courseInfo.url}/course-documents/delete/{$group.id}/#deletegroup" title="Delete group" class="btn btn-danger btn-sm"><span class="fa fa-trash fa-fw"></span> Delete</a>{/if}</div></li>
    {/foreach}
    </ul>
</div>