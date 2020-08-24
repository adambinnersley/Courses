{strip}
{foreach $videos as $video}
    {$video.information->snippet->thumbnails->standard->url}
    <pre>
    {$video.information|print_r}
    </pre>
{/foreach}
{/strip}