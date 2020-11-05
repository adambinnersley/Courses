{strip}
<div class="row">
    {assign var="first" value=1}
    {foreach $documents as $doc}
        {if $group != $doc.group && $doc.group}{if !$first}</ul></div></div>{/if}<div class="col-md-4 col-sm-6"><div class="card"><div class="card-header">{$doc.group}</div>{if $userDetails.isHeadOffice}<ul class="list-group">{/if}{/if}

        {assign var="group" value=$doc.group}
        {if $userDetails.isHeadOffice}<li class="list-group-item">{/if}<a href="/student/learning/{$courseInfo.url}/documents/{$doc.file}" title="{$doc.link_text}" target="_blank"{if !$userDetails.isHeadOffice} class="list-group-item"{/if}>{$doc.link_text}</a>{if $userDetails.isHeadOffice}<div class="float-right"><a href="/student/learning/{$courseInfo.url}/course-documents/{$doc.id}/edit" title="Edit item" class="btn btn-warning btn-sm"><span class="fa fa-pencil-alt fa-fw"></span> Edit</a> <a href="/student/learning/{$courseInfo.url}/course-documents/{$doc.id}/delete" title="Delete item" class="btn btn-danger btn-sm"><span class="fa fa-trash fa-fw"></span> Delete</a></div></li>{/if}
        {assign var="first" value=false}
    {/foreach}
    {if $userDetails.isHeadOffice}</ul>{/if}
        </div>
    </div>
</div>
{/strip}