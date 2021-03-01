{strip}
{assign var="headerSection" value="Tests" scope="global"}
{assign var="title" value=$headerSection scope="global"}
{include file="assets/page-header.tpl"}
{if $testdetails}
{assign var="backURL" value="tests/" scope="global"}
{assign var="backText" value="Back to Tests" scope="global"}
{/if}
{if $userDetails.isHeadOffice}
    <div class="row"><div class="col-12"><a href="/student/learning/{$courseInfo.url}/tests/add" title="Add new test" class="btn btn-success float-right"><span class="fa fa-plus fa-fw"></span> Add new test</a></div></div>{/if}
{include file="assets/back-button.tpl"}
<div class="row">
    <div class="col-12">
        {if $tests}
            {if !$testdetails}
                <table class="table table-striped table-hover table-bordered">
                    <tr>
                        <th></th>
                        <th class="text-center">No. Questions</th>
                        <th class="text-center">Pass mark</th>
                        {if !$userDetails.isHeadOffice}<th class="text-center">Score</th>
                        <th class="text-center">Status</th>
                        {else}
                        <th class="text-center">Submissions</th>
                        <th class="text-center"></th>
                        {/if}
                        <th></th>
                    </tr>
                    {foreach $tests as $test}
                        <tr>
                            <td>{$test.name}{if $test.active == 0}<strong class="text-danger">- Disabled</strong>{/if}</td>
                            <td class="text-center">{$test.no_questions}</td>
                            <td class="text-center">{if $test.pass_mark}{$test.pass_mark}/{$test.max_score}{elseif $test.pass_percentage}{$test.pass_percentage}%{elseif $test.self_assessed}Self assessed{/if}</td>
                            {if !$userDetails.isHeadOffice}<td class="text-center">{if $test.results.status == 0 || $test.results.status == 1}0{else}{$test.results.score}{/if}/{$test.max_score}</td>
                            <td class="text-center">
                                {if $test.results.status == 0}<strong class="text-warning">Incomplete</strong>
                                {elseif $test.results.status == 1 && !$test.self_assessed}<strong class="text-info">Awaiting marking</strong>
                                {elseif $test.results.status == 2}<strong class="text-danger">Failed</strong>
                                {elseif $test.results.status == 3}<strong class="text-success">Passed</strong>
                                {/if}
                            </td>
                            <td class="text-center">{if $test.results.status >= 2 || ($test.self_assessed && $test.results.status == 1)}<a href="?review={$test.test_id}" title="Review" class="btn btn-info">Review Test</a>{/if}{if $test.results.status == 0 || $test.results.status == 2} <a href="?take={$test.test_id}" title="Take {$test.name}" class="btn btn-success">{if $test.results.status == 2}Retake{else}Start{/if} Test</a>{/if}</td>
                            {else}
                            <td class="text-center">{if $test.submissions.total > 0}{$test.submissions.total} Total{else}None{/if}{if $test.submissions.unmarked >= 1} <div class="badge">{$test.submissions.unmarked} Unmarked</div>{/if}</td>
                            <td class="text-center">{if $test.submissions.total >= 1}<a href="/student/learning/{$courseInfo.url}/tests/submissions/{$test.test_id}" title="Submissions" class="btn btn-info">View Submissions</a>{/if}</td>
                            <td class="text-center"><a href="/student/learning/{$courseInfo.url}/tests/{$test.test_id}/edit" title="Edit Page" class="btn btn-warning"><span class="fa fa-pencil-alt fa-fw"></span> Edit</a> <a href="/student/learning/{$courseInfo.url}/tests/{$test.test_id}/delete" title="Delete Page" class="btn btn-danger"><span class="fa fa-trash fa-fw"></span> Delete</a></td>{/if}
                        </tr>    
                    {/foreach}
                </table>
            {elseif $testSubmitted && !$testdetails}
                {include file="tests/testSubmitted.tpl"}
            {else}
                {include file="tests/takeTest.tpl"}
            {/if}
        {else}
            <div class="col-md-12 text-center">There are currently no tests for this course</div>
        {/if}
    </div>
</div>
{assign var="footerBtn" value="true" scope="global"}
{include file="assets/back-button.tpl"}
{/strip}