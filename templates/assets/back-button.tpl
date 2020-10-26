{strip}
    <div class="row">
        <div class="col-12 {if isset($footerBtn)}mt-3{else}mb-3{/if}">
            <a href="/student/learning/{$courseInfo.url}/{$backURL}" title="{if isset($backText)}{$backText}{else}Course home{/if}" class="btn btn-danger">{if isset($backText)}&laquo; {$backText}{else}<span class="fas fa-home"></span> Course home{/if}</a>
        </div>
    </div>
{/strip}