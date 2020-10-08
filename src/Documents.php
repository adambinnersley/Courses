<?php
namespace Courses;

use Upload\FileUploadDBAL;

class Documents extends FileUploadDBAL
{
    protected $db;
    protected $upload;
    
    protected $upload_database = 'course_documents';
    protected $doc_group = 'course_doc_groups';
    
    /**
     * Return the document information by ID
     * @param int $documentID This should be the unique ID of the document
     * @return array|false If the document exists will return an array of the document information else will return false
     */
    public function getDocumentByID($documentID)
    {
        return $this->db->select($this->upload_database, ['id' => intval($documentID)]);
    }
    
    /**
     * Returns the document information by filename
     * @param string $file This should be the documents filename
     * @param int $courseID This should be the course ID the filename is associated with as files can be uploaded for different courses with the same name but be slightly different
     * @return array|false If the document exists will return an array of the document information else will return false
     */
    public function getDocumentByFilename($file, $courseID)
    {
        return $this->db->select($this->upload_database, ['course_id' => intval($courseID), 'file' => $file]);
    }
    
    /**
     * Gets a list of all of the course documents for a given course
     * @param int|false $courseID This should be the course ID if you only want documents for a given course else set to false for all documents
     * @return array|boolean If any documents exist will return an array of the documents else will return false if none exist
     */
    public function getDocuments($courseID = false)
    {
        if (is_numeric($courseID)) {
            $where = " AND `{$this->upload_database}`.`course_id` = ".intval($courseID);
        }
        return $this->db->query("SELECT `{$this->upload_database}`.`id`, `{$this->upload_database}`.`course_id`, `{$this->upload_database}`.`link_text`, `{$this->upload_database}`.`file`, `{$this->doc_group}`.`name` as `group` FROM `{$this->doc_group}`, `{$this->upload_database}` WHERE `{$this->upload_database}`.`group_id` = `{$this->doc_group}`.`id`".$where." ORDER BY `{$this->upload_database}`.`group_id` ASC;");
    }
    
    /**
     * Adds a new document to the database
     * @param int $courseID This should be the ID of the course that you are adding this document to
     * @param int $groupID The ID of the group that this document should appear in
     * @param string $text The text that should be displayed for the document
     * @param file $file The file that you are attaching to the course
     * @param array $information Any additional information in the form of an array that need adding to the database
     * @return boolean If the document has successfully been added will return true else returns false
     */
    public function addDocument($courseID, $groupID, $text, $file, $information = [])
    {
        if ($file['name'] && $this->checkMimeTypes($file) && $this->fileExtCheck($file) && $this->fileSizeCheck($file)) {
            $insert = array_filter(array_merge(['course_id' => intval($courseID), 'group_id' => intval($groupID), 'link_text' => trim($text), 'file' => $this->makeURLSafe($file['name']), 'type' => $file['type'], 'size' => $file['size'], 'content' => file_get_contents($file['tmp_name'])], array_filter($information)));
            return $this->db->insert($this->upload_database, $insert);
        }
    }
    
    /**
     * Updates a document and its information
     * @param int $documentID This should be the documents unique ID
     * @param int $groupID This should be the group that you wish to display this document in
     * @param string $text The text that should be displayed for the document
     * @param file $file The file that you are attaching to the course
     * @param array $information Any additional information or updates in the form of an array that need adding to the database
     * @return boolean If the document has successfully been updated will return true else returns false
     */
    public function updateDocument($documentID, $groupID, $text, $file = null, $information = [])
    {
        if ($file !== null && !empty($file['name']) && $this->checkMimeTypes($file) && $this->fileExtCheck($file) && $this->fileSizeCheck($file)) {
            $information = array_merge(['file' => $this->makeURLSafe($file['name']), 'type' => $file['type'], 'size' => $file['size'], 'content' => file_get_contents($file['tmp_name'])], $information);
        }
        return $this->db->update($this->upload_database, array_merge(['group_id' => intval($groupID), 'link_text' => trim($text)], array_filter($information)), ['id' => $documentID]);
    }
    
    /**
     * Delete a document from the database
     * @param int $documentID This should be the unique document ID
     * @return boolean If the record is deleted will return true else returns false
     */
    public function deleteDocument($documentID)
    {
        return $this->deleteFileByID($documentID);
    }
    
    /**
     * Adds a new group to the database which the documents can be assigned to
     * @param int $courseID This should be the course ID that the group is assigned to
     * @param string $name This should be the name of the group
     * @param array $additionalInfo Any additional information about the group can be added here
     * @return boolean If the group has been added will return true else return false
     */
    public function addGroup($courseID, $name, $additionalInfo = [])
    {
        $insert = array_filter(array_merge(['course_id' => intval($courseID), 'name' => $name], $additionalInfo));
        return $this->db->insert($this->doc_group, $insert);
    }
    
    /**
     * Edits a document group and its information stored in the database
     * @param int $groupID This should be the unique group ID that you are editing the information for
     * @param array $information This should be any information that you wish to update in the form of an array with field name and value
     * @return booolean If the information is successfully updated will return true else return false
     */
    public function editGroup($groupID, $information = [])
    {
        return $this->db->update($this->doc_group, $information, ['id' => $groupID]);
    }
    
    /**
     * Deletes a document group from the database
     * @param int $groupID This should be the group ID
     * @return boolean If the group has been deleted will return true else return false
     */
    public function deleteGroup($groupID)
    {
        return $this->db->delete($this->doc_group, ['id' => $groupID]);
    }
    
    /**
     * Returns the information for a single group of the given ID
     * @param int $groupID This should be the group ID
     * @return array|false If the group exists an array will be returned else will return false
     */
    public function getGroupByID($groupID)
    {
        return $this->db->select($this->doc_group, ['id' => $groupID]);
    }
    
    /**
     * Returns all of the groups for a given course
     * @param int $courseID This should be the course ID you are wanting the groups for
     * @return array|boolean If groups exist will return an array of the information else will return false
     */
    public function getGroups($courseID = false)
    {
        return $this->db->query("SELECT *, (SELECT count(*) FROM `{$this->upload_database}` WHERE `{$this->upload_database}`.`group_id` = `{$this->doc_group}`.`id`) as `items` FROM `{$this->doc_group}`".(is_numeric($courseID) ? " WHERE `course_id` = ".intval($courseID) : "")." ORDER BY `items` DESC;");
    }
    
    /**
     * Remove any unusual character and make the filename safe for browsers
     * @param string $filename This should be the current name of the file being uploaded
     * @return string The new name to give to the file which is safe for displaying in the URL
     */
    protected function makeURLSafe($filename)
    {
        return strtolower(filter_var(str_replace(' ', '-', $filename), FILTER_SANITIZE_URL));
    }
}
