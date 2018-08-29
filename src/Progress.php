<?php

namespace Courses;

use DBAL\Database;
use Users\User;

class Progress{
    protected $db;
    
    const PAGE_PROGRESS = 'course_content_user_progress';
    
    /**
     * Add the instance of the Database class to use in this class
     * @param Database $db Should be an instance of the database class
     */
    public function __construct(Database $db){
        $this->db = $db;
    }
    
    /**
     * Retrieves the users progress for a given page
     * @param int $userID This should be the users ID
     * @param int $userType This should be the type of users (1 = student, 2 = instructor)
     * @param int $pageID This should be the page ID of the page you wish to retrieve the information for
     * @return array|boolean If any information exist it will be returned as an array else will return false
     */
    public function getUserPageProgress($userID, $userType, $pageID){
        return $this->db->select(self::PAGE_PROGRESS, array('user_id' => intval($userID), 'is_instructor' => intval($userType), 'page_id' => intval($pageID)));
    }
    
    /**
     * 
     * @param int $userID This should be the users ID
     * @param int $userType This should be the type of users (1 = student, 2 = instructor)
     * @param int $pageID This should be the unique page id to add data for this user
     * @param int $time The total amount of second that the user has spent on the given page
     * @return boolean If the information has been added/updated will return true else will return false
     */
    public function addUserPageProgress($userID, $userType, $pageID, $time = 0){
        if($this->getUserPageProgress($userID, $userType, $pageID)){
            return $this->updateUserPageProgress($userID, $userType, $pageID, $time);
        }
        return $this->db->insert(self::PAGE_PROGRESS, array('user_id' => intval($userID), 'is_instructor' => intval($userType), 'page_id' => intval($pageID), 'time_spent' => intval($time)));
    }
    
    /**
     * Updates the users progress for a given page
     * @param int $userID This should be the users ID
     * @param int $userType This should be the type of users (1 = student, 2 = instructor)
     * @param int $pageID This should be the unique page id to update data for this user
     * @param int $time The total amount of second that the user has spent on the given page
     * @return boolean If the information has been updated will return true else returns false
     */
    protected function updateUserPageProgress($userID, $userType, $pageID, $time = 0){
        return $this->db->update(self::PAGE_PROGRESS, array('time_spent' => intval($time)), array('user_id' => intval($userID), 'is_instructor' => intval($userType), 'page_id' => intval($pageID)), 1);
    }
    
    /**
     * Deletes the users progress/ time spent on page for a given page
     * @param int $userID This should be the users ID
     * @param int $userType This should be the type of users (1 = student, 2 = instructor)
     * @param int $pageID This should be the unique page id that you wish to delete the users data for
     * @return boolean If the data has been delete will return true else returns false
     */
    public function deleteUserPageProgress($userID, $userType, $pageID){
        return $this->db->delete(self::PAGE_PROGRESS, array('user_id' => intval($userID), 'is_instructor' => intval($userType), 'page_id' => intval($pageID)), 1);
    }
    
    /**
     * Deletes all of the users progress and time spent on pages
     * @param int $userID This should be the users ID
     * @param int $userType This should be the type of users (1 = student, 2 = instructor)
     * @return boolean If all of the users progress has been removed will return true else will return false
     */
    public function deleteAllUserPageProgress($userID, $userType){
        return $this->db->delete(self::PAGE_PROGRESS, array('user_id' => intval($userID), 'is_instructor' => intval($userType)));
    }
}