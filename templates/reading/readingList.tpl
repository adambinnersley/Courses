{strip}
{assign var="title" value="Reading List" scope="global"}
{if $readingList}
    <div class="col-12">
        <div class="row">
            {foreach $readingList as $item}
                {if !$readingtype}
                <div class="col-lg-6">
                    {if $item.resource_type == 1}<h3>Books</h3>{elseif $item.resource_type == 2}<h3>Useful links</h3>{/if}
                    <div class="list-group">
                {/if}
                {if $readingtype && ($readingtype != $item.resource_type)}
                        </div>
                    </div>
                    <div class="col-lg-6">
                        {if $item.resource_type == 1}<h3>Books</h3>{elseif $item.resource_type == 2}<h3>Useful links</h3>{/if}
                        <div class="list-group">
                {/if}
                {if $item.link && $item.resource_type == 2 && !$userDetails.isHeadOffice}<a href="{$item.link}" title="{$item.title}" target="_blank" class="list-group-item">{else}<div class="list-group-item">{/if}
                    {if $userDetails.isHeadOffice}<div class="float-right"><a href="/student/learning/{$courseInfo.url}/reading-list/edit/{$item.id}" title="Edit item" class="btn btn-warning"><span class="fa fa-pencil-alt fa-fw"></span> Edit</a> <a href="/student/learning/{$courseInfo.url}/reading-list/delete/{$item.id}" title="Delete item" class="btn btn-danger"><span class="fa fa-trash fa-fw"></span> Delete</a></div>{/if}
                    <span class="fa fa-{if $item.resource_type == 1}book{elseif $item.resource_type == 2}link{/if} fa-fw"></span> {if $item.resource_type == 1}<strong>{/if}{$item.title}{if $item.resource_type == 1}</strong>{/if}
                    {if $userDetails.isHeadOffice && $item.link && $item.resource_type == 2}<br /><small>{$item.link}</small>{/if}
                    {if $item.description}<br /><small>{$item.description}</small>{/if}
                    {if $item.resource_type == 1}
                        {if $item.author}<br /><small><strong>Author:</strong> {$item.author}</small>{/if}
                        {if $item.publisher}<br /><small><strong>Publisher:</strong> {$item.publisher}</small>{/if}
                        {if $item.publish_date}<br /><small><strong>Publish Date:</strong> {$item.publish_date}</small>{/if}
                        {if $item.isbn}<br /><small><strong>ISBN:</strong> {$item.isbn}</small>{/if}
                        {if $item.link}<br /><small><strong>Link:</strong> <a href="{$item.link}" title="{$item.title}">{$item.link}</a></small>{/if}
                    {/if}
                {if $item.link && $item.resource_type == 2 && !$userDetails.isHeadOffice}</a>{else}</div>{/if}
                {assign var="readingtype" value=$item.resource_type}
            {/foreach}
        </div>
    </div>
{else}
    
{/if}
{/strip}