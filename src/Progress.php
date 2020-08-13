<?php

namespace Courses;

use DBAL\Database;
use Configuration\Config;

class Progress{
    protected $db;
    protected $config;
    
    /**
     * Add the instance of the Database class to use in this class
     * @param Database $db Should be an instance of the database class
     */
    public function __construct(Database $db, Config $config){
        $this->db = $db;
        $this->config = $config;
    }
    
    /**
     * Retrieves the users progress for a given page
     * @param int $userID This should be the users ID
     * @param int $pageID This should be the page ID of the page you wish to retrieve the information for
     * @param boolean $isInstructor If the user is an instructor set to true else should be false
     * @return array|boolean If any information exist it will be returned as an array else will return false
     */
    public function getUserPageProgress($userID, $pageID, $isInstructor = false){
        return $this->db->select($this->config->course_content_user_progress, [($isInstructor === true ? 'instructor_id' : 'user_id') => $userID, 'page_id' => intval($pageID)]);
    }
    
    /**
     * 
     * @param int $userID This should be the users ID
     * @param int $pageID This should be the unique page id to add data for this user
     * @param boolean $isInstructor If the user is an instructor set to true else should be false
     * @param int $time The total amount of second that the user has spent on the given page
     * @return boolean If the information has been added/updated will return true else will return false
     */
    public function addUserPageProgress($userID, $pageID, $isInstructor = false, $time = 0){
        if($this->getUserPageProgress($userID, $pageID, $isInstructor)){
            return $this->updateUserPageProgress($userID, $pageID, $isInstructor, $time);
        }
        return $this->db->insert($this->config->course_content_user_progress, [($isInstructor === true ? 'instructor_id' : 'user_id') => intval($userID), 'page_id' => intval($pageID), 'time_spent' => intval($time)]);
    }
    
    /**
     * Updates the users progress for a given page
     * @param int $userID This should be the users ID
     * @param int $pageID This should be the unique page id to update data for this user
     * @param boolean $isInstructor If the user is an instructor set to true else should be false
     * @param int $time The total amount of second that the user has spent on the given page
     * @return boolean If the information has been updated will return true else returns false
     */
    protected function updateUserPageProgress($userID, $pageID, $isInstructor = false, $time = 0){
        return $this->db->update($this->config->course_content_user_progress, ['time_spent' => intval($time)], [($isInstructor === true ? 'instructor_id' : 'user_id') => intval($userID), 'page_id' => intval($pageID)], 1);
    }
    
    /**
     * Deletes the users progress/ time spent on page for a given page
     * @param int $userID This should be the users ID
     * @param int $pageID This should be the unique page id that you wish to delete the users data for
     * @param boolean $isInstructor If the user is an instructor set to true else should be false
     * @return boolean If the data has been delete will return true else returns false
     */
    public function deleteUserPageProgress($userID, $pageID, $isInstructor = false){
        return $this->db->delete($this->config->course_content_user_progress, [($isInstructor === true ? 'instructor_id' : 'user_id') => intval($userID), 'page_id' => intval($pageID)], 1);
    }
    
    /**
     * Deletes all of the users progress and time spent on pages
     * @param int $userID This should be the users ID
     * @param boolean $isInstructor If the user is an instructor set to true else should be false
     * @return boolean If all of the users progress has been removed will return true else will return false
     */
    public function deleteAllUserPageProgress($userID, $isInstructor = false){
        return $this->db->delete($this->config->course_content_user_progress, [($isInstructor === true ? 'instructor_id' : 'user_id') => intval($userID)]);
    }
}