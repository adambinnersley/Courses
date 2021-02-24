<form method="post" action="" class="form-horizontal">
    <div class="card border-primary">
        <div class="card-header bg-primary font-weight-bold">{$testdetails.name}</div>
        <ul class="list-group list-group-flush">
        {foreach $testdetails.questions as $i => $question}
            <li class="list-group-item">
                <h5 class="card-title">Q{$i + 1}. {$question.question}</h5>
                {if $reviewInfo && $reviewInfo[$i].marked}
                    <div class="alert alert-info">
                        <strong>Score:</strong> {$reviewInfo[$i].score} out of a possible {$reviewInfo[$i].max_score}
                        {if $reviewInfo[$i].feedback}<br /><strong>Feedback:</strong> {$reviewInfo[$i].feedback}{/if}
                    </div>
                {/if}
            {if $question.question_type == 1}
                {if !$reviewInfo}
                    <textarea name="question{$i + 1}" id="question{$i + 1}" rows="6" class="form-control"></textarea>
                {else}
                    <p><strong>Your answer:</strong> {$reviewInfo[$i].answer}</p>
                    {if $testdetails.self_assessed}
                        <p class="text-info"><strong>Official answer:</strong> {$question.answers}</p>
                        {if $question.question_type != 2}
                            <div class="form-group row">
                                <label for="score_{$i + 1}" class="col-md-2 control-label">Question Status</label>
                                <div class="col-md-10 form-inline">
                                    <select name="score[{$question.question_id}]" id="score_{$question.question_id}" class="form-control">
                                        <option value="unmarked"{if $question.marked == 0} selected="selected"{/if}>Unmarked</option>
                                        {for $i=0 to $question.max_score}
                                            <option value="{$i}"{if $question.score == $i && $question.marked == 1} selected="selected"{/if}>{if $i == 1}Correct{else}Incorrect{/if}</option>
                                        {/for}
                                    </select>
                                </div>
                            </div>
                        {/if}
                    {/if}
                {/if}
            {elseif $question.question_type == 2}
                {if !$reviewInfo}
                    {assign var="correct" value=0}
                    {foreach $question.answers as $answer}
                        {if $answer.correct}{assign var="correct" value=$correct+1}{/if}
                    {/foreach}
                    <p class="text-danger" id="question{$i + 1}-mark" data-mark="{$correct}"><strong><em>Mark {$correct} answer{if $correct > 1}s{/if}</em></strong></p>
                {/if}
                <div class="row">
                {foreach $question.answers as $a => $answer}
                    <div class="col-sm-6">
                        <label class="question-label{if $reviewInfo} reviewing{if $reviewInfo[$i].answers[$a].correct && $reviewInfo[$i].answer == $a} label-correct{elseif $reviewInfo[$i].answer == $a} label-incorrect{elseif $answer.correct == 1} label-selected{/if}{/if}" for="question{$i + 1}_{$a}">
                            <input type="{if $correct == 1}radio{else}checkbox{/if}" name="{if $correct == 1}question{$i + 1}{else}question{$i + 1}[{$a}]{/if}" id="question{$i + 1}_{$a}" data-question="question{$i + 1}" value="{if $correct == 1}{$a}{else}1{/if}" />
                            {$answer.answer}
                        </label>
                    </div>
                {/foreach}
                </div>
            {/if}
            </li>
        {/foreach}
        {if !$reviewInfo}
            <div class="text-center"><input type="submit" name="submit" id="submit" value="Submit Test" class="btn btn-success btn-lg my-3" /></div>
        {/if}
    </div>
</form>
{if !$reviewInfo}
<script type="text/javascript">{literal}
var checked = {};
$("input[type='radio']").click(function(){
if($(this).parent('.question-label').hasClass('label-selected')){
    $(this).prop("checked", false);
    $(this).parent('.question-label').removeClass('label-selected');
}
else{
    $("[id^="+$(this).attr('name')+"]").parent('.question-label').removeClass('label-selected');
    $(this).parent('.question-label').addClass('label-selected');
}
});

$("input[type='checkbox']").click(function(){
if(!$(this).is(':checked')){
    checked["num"+$(this).data('question')]--;
    $(this).parent('.question-label').removeClass('label-selected');
}
else{
    if(!checked["num"+$(this).data('question')]){
        checked["num"+$(this).data('question')] = 1;
    }
    else{
        checked["num"+$(this).data('question')]++;
    }
    if(checked["num"+$(this).data('question')] > $("#"+$(this).data('question')+"-mark").data('mark')){
        $(this).prop("checked", false);
        checked["num"+$(this).data('question')]--;
        alert('Only '+$("#"+$(this).data('question')+"-mark").data('mark')+' answers can be selected, you must uncheck one of your other answers before you can select this one');
    }
    else{
        $(this).parent('.question-label').addClass('label-selected');
    }
}
});
{/literal}</script>
{/if}