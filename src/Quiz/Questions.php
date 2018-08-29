<?php

namespace Courses\Quiz;

use DBAL\Database;

class Questions{
    protected $db;
    
    const QUESTIONS_TABLE = 'course_test_questions';
    
    /**
     * Should provide an instance of the database class to use
     * @param Database $db This should be an instance of the Database class
     */
    public function __construct(Database $db) {
        $this->db = $db;
    }
    
    /**
     * Gets a single question details
     * @param int $questionID This should be the unique question ID
     * @return array|boolean If the question exists the details will be returned as a multi-dimensional array else will return false
     */
    public function getQuestionInfo($questionID){
        $question = $this->db->select(self::QUESTIONS_TABLE, array('question_id' => $questionID));
        if($question){
            if(intval($question['question_type']) === 2){
                $question['answers'] = unserialize($question['answers']);
            }
            return $question;
        }
        return false;
    }
    
    /**
     * Gets a list of all of the questions for a given test ID
     * @param int $testID This should be the unique test ID you are retrieving questions for
     * @return array|boolean If questions exist for the given test ID will return a multi-dimensional array else will return false
     */
    public function getTestQuestions($testID){
        if(is_numeric($testID)){
            $questions = $this->db->selectAll(self::QUESTIONS_TABLE, array('test_id' => $testID), '*', array('question_order' => 'ASC'));
            foreach($questions as $i => $question){
                if(intval($question['question_type']) === 2){
                    $questions[$i]['answers'] = unserialize($question['answers']);
                }
            }
            return $questions;
        }
        return false;
    }
    
    /**
     * Adds a question to the database
     * @param int $testID This should be the Test ID that you are adding the question to
     * @param array $questionInfo This should be the POST data array containing the question information
     * @param int|boolean $order If the question has already been assigned an order else this number here else will be given the next available question number
     * @return boolean If the question is successfully inserted will return 
     */
    public function addQuestion($testID, $questionInfo, $order = false){
        if($questionInfo['type'] == 1){$answers = (!empty(trim($questionInfo['answer'])) ? $questionInfo['answer'] : NULL);}
        else{$answers = $this->serializeAnswers($questionInfo['answers']);}
        if(empty(trim($questionInfo['explanation']))){$questionInfo['explanation'] = 'NULL';}
        
        if(is_numeric($order)){$questionOrder = intval($order);}else{$questionOrder = $this->getNextAvailableOrder($testID);}// Get the next order num for this test
        return $this->db->insert(self::QUESTIONS_TABLE, array('test_id' => $testID, 'question_order' => $questionOrder, 'question' => trim($questionInfo['q']), 'answers' => $answers, 'question_type' => intval($questionInfo['type']), 'max_score' => intval($questionInfo['score']), 'allow_partial' => intval($questionInfo['partial']), 'explanation' => $questionInfo['explanation']));
    }
    
    /**
     * Updates a given question information
     * @param int $questionID This should be the ID of the question you are changing
     * @param array $questionInfo This should be the new Question information in a multi-dimensional array
     * @return boolean If the Information is updated will return true else will return false
     */
    public function updateQuestion($questionID, $questionInfo){
        if($questionInfo['type'] == 1){$answers = (!empty(trim($questionInfo['answer'])) ? $questionInfo['answer'] : NULL);}
        else{$answers = $this->serializeAnswers($questionInfo['answers']);}
        if(empty(trim($questionInfo['explanation']))){$questionInfo['explanation'] = 'NULL';}
        
        return $this->db->update(self::QUESTIONS_TABLE, array('question' => $questionInfo['q'], 'answers' => $answers, 'question_type' => $questionInfo['type'], 'max_score' => $questionInfo['score'], 'allow_partial' => $questionInfo['partial'], 'explanation' => $questionInfo['explanation']), array('question_id' => $questionID));
    }
    
    /**
     * Deletes a specific question based on the given question ID and reorders the remaining questions in the specific test
     * @param int $questionID This should be the ID of the question you wish to delete
     * @return boolean If the question has been deleted will return true else will return false
     */
    public function deleteQuestion($questionID){
        if(is_numeric($questionID)){
            $questionInfo = $this->db->select(self::QUESTIONS_TABLE, array('question_id' => $questionID));
            if($this->db->delete(self::QUESTIONS_TABLE, array('question_id' => $questionID), 1)){
                foreach($this->db->selectAll(self::QUESTIONS_TABLE, array('test_id' => $questionInfo['test_id'], 'question_order' => array('>=', $questionInfo['question_order'])), '*', array('question_order' => 'ASC')) as $question){
                    $this->db->update(self::QUESTIONS_TABLE, array('question_order' => intval($question['question_order'] - 1)), array('question_id' => $question['question_id']), 1);
                }
                return true;
            }
        }
        return false;
    }
    
    /**
     * Get the maximum score possible for a given test ID
     * @param int $testID This should be the unique test ID
     * @return int This will be the maximum possible score available for the test
     */
    public function getMaxScore($testID){
        $score = $this->db->query("SELECT SUM(`max_score`) as `max_mark` FROM `".self::QUESTIONS_TABLE."` WHERE `test_id` = ?;", array($testID));
        return $score[0]['max_mark'];
    }

    /**
     * Gets the ID of the next question
     * @param int $testID The test ID that you are getting the next question for
     * @param int $currentQuestion The current question order number
     * @return int|boolean If a next question id will be return if a next question exists else will return false
    public function getNextQuestionID($testID, $currentQuestion){
        if(is_numeric($testID) && is_numeric($currentQuestion)){
            $questionInfo = $this->db->select(self::QUESTIONS_TABLE, array('test_id' => $testID, 'question_order' => ($currentQuestion + 1)));
            return $questionInfo['question_id'];
        }
        return false;
    }*/
    
    /**
     * Gets the ID of the previous question
     * @param int $testID The test ID that you are getting the previous question for
     * @param int $currentQuestion The current question order number
     * @return int|boolean If a next question id will be return if a previous question exists else will return false
    public function getPrevQuestionID($testID, $currentQuestion){
        if(is_numeric($testID) && is_numeric($currentQuestion)){
            $questionInfo = $this->db->select(self::QUESTIONS_TABLE, array('test_id' => $testID, 'question_order' => ($currentQuestion - 1)));
            return $questionInfo['question_id'];
        }
        return false;
    }*/
    
    /**
     * Changes the question order
     * @param int $questionID The ID of the question you are changing of the order of
     * @param boolean $moveUp If you are moving the question up should be set to true else moving down set to false
     */
    public function changeQuestionOrder($questionID, $moveUp = true){
        
    }
    
    /**
     * Gets the next available question order
     * @param int $testID The test ID that you are getting the next question order available for
     * @return int The next question order available will be returned
     */
    private function getNextAvailableOrder($testID){
        if(is_numeric($testID)){
            $order = $this->db->select(self::QUESTIONS_TABLE, array('test_id' => $testID), array('question_order'), array('question_order' => 'DESC'));
            return intval($order['question_order'] + 1);
        }
        return 1;
    }
    
    /**
     * Serialize the question answers 
     * @param array $answers The answers for the given questions
     * @return string The serialized string of the question answers will be returned
     */
    private function serializeAnswers($answers){
        foreach($answers as $i => $answer){
            if(empty($answer['answer'])){unset($answers[$i]);}
        }
        return serialize(array_filter($answers));
    }
}
