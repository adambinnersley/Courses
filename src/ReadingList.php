<?php

namespace Courses;

use Configuration\Config;
use DBAL\Database;
use DBAL\Modifiers\Modifier;

class ReadingList
{
    protected $db;
    protected $config;
    
    /**
     * Should provide an instance of the database class to use
     * @param Database $db This should be an instance of the Database class
     */
    public function __construct(Database $db, Config $config)
    {
        $this->db = $db;
        $this->config = $config;
    }
    
    /**
     * Returns all of the reading list items for a given course ID
     * @param int $courseID This should be the course ID that you wish to get all of the reading list items for
     * @return array|boolean If the course has any reading list item they will be returned as an array else will return false
     */
    public function getReadingList($courseID)
    {
        return $this->db->selectAll($this->config->table_course_reading, ['course_id' => $courseID], '*', ['resource_type' => 'ASC']);
    }
    
    /**
     * Gets the details of a specific item
     * @param int $courseID This should be the course ID that you wish to get the item details for
     * @param int $linkID The link id of the item you wish to get the information for
     * @return array|boolean If the item exists the details will be returned in an array else will return false
     */
    public function getItemDetails($courseID, $linkID)
    {
        return $this->db->select($this->config->table_course_reading, ['id' => $linkID, 'course_id' => $courseID]);
    }


    /**
     * Add a reading list item to a given course
     * @param int $courseID The ID of the course you are adding the link to
     * @param string $title The title for reading list item
     * @param int $resouceType Should be the type of item (1 = book, 2 = web-page)
     * @param string|null $link Any links to the book|web-page etc
     * @param string|null $author The author of the reading list item
     * @param string|null $description A description for the reading list item
     * @param string|null $isbn The ISBN number for the item
     * @param string|null $publisher The published if it is a book
     * @param string|null $publishDate The published date for any books (doesn't need to be a date, simply a string)
     * @return boolean
     */
    public function addItem($courseID, $title, $resouceType, $link = null, $author = null, $description = null, $isbn = null, $publisher = null, $publishDate = null)
    {
        return $this->db->insert($this->config->table_course_reading, ['course_id' => intval($courseID), 'title' => $title, 'resource_type' => intval($resouceType), 'author' => Modifier::setNullOnEmpty($author), 'publisher' => Modifier::setNullOnEmpty($publisher), 'publish_date' => Modifier::setNullOnEmpty($publishDate), 'isbn' => Modifier::setNullOnEmpty($isbn), 'description' => Modifier::setNullOnEmpty($description), 'link' => Modifier::setNullOnEmpty($link)]);
    }
    
    /**
     * Updates a reading list item based on the link ID given and the new information
     * @param int $linkID The link ID of the reading list item you wish to update
     * @param string $title The title for reading list item
     * @param int $resouceType Should be the type of item (1 = book, 2 = web-page)
     * @param string|null $link Any links to the book|web-page etc
     * @param string|null $author The author of the reading list item
     * @param string|null $description A description for the reading list item
     * @param string|null $isbn The ISBN number for the item
     * @param string|null $publisher The published if it is a book
     * @param string|null $publishDate The published date for any books (doesn't need to be a date, simply a string)
     * @return boolean If the reading list item is updated true will be returned else will return false
     */
    public function updateItem($linkID, $title, $resouceType, $link = null, $author = null, $description = null, $isbn = null, $publisher = null, $publishDate = null)
    {
        return $this->db->update($this->config->table_course_reading, ['title' => $title, 'resource_type' => intval($resouceType), 'author' => Modifier::setNullOnEmpty($author), 'publisher' => Modifier::setNullOnEmpty($publisher), 'publish_date' => Modifier::setNullOnEmpty($publishDate), 'isbn' => Modifier::setNullOnEmpty($isbn), 'description' => Modifier::setNullOnEmpty($description), 'link' => Modifier::setNullOnEmpty($link)], ['id' => $linkID], 1);
    }
    
    /**
     * Deletes a single reading list item based on the given link ID
     * @param int $linkID The link ID of the link you wish to delete
     * @return boolean If the item is deleted will return true else will return false
     */
    public function deleteItem($linkID)
    {
        if (is_numeric($linkID)) {
            return $this->db->delete($this->config->table_course_reading, ['id' => $linkID], 1);
        }
        return false;
    }
    
    /**
     * Deletes all of the reading list items for a given course ID
     * @param int $courseID This should be the course ID of the course you want to delete all of the reading list for
     * @return boolean If everything is deleted will return true else will return false
     */
    public function deleteCourseItems($courseID)
    {
        if (is_numeric($courseID)) {
            return $this->db->delete($this->config->table_course_reading, ['course_id' => $courseID]);
        }
        return false;
    }
    
    /**
     * Copy the reading list items from one course to another
     * @param int $courseID The course ID of the course you wish to copy
     * @param int $newCourseID The course ID of the new course you want to copy to
     * @return boolean If the items are copied it will return true else will return false
     */
    public function copyCourseItems($courseID, $newCourseID)
    {
        $readingList = $this->getReadingList($courseID);
        if (is_numeric($newCourseID) && is_array($readingList)) {
            foreach ($readingList as $item) {
                $this->addItem($newCourseID, $item['title'], $item['resource_type'], $item['link'], $item['author'], $item['description'], $item['isbn'], $item['publisher'], $item['publish_date']);
            }
            return true;
        }
        return false;
    }
}
