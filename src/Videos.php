<?php

namespace Courses;

use DBAL\Database;
use Madcoda\Youtube\Youtube;

class Videos{
    protected static $db;
    
    protected $video_table = 'course_videos';
    protected $google_api_key;
    
    /**
     * Constructor to add an instance of the Database instance 
     * @param Database $db Instance of the database instance
     */
    public function __construct(Database $db){
        self::$db = $db;
    }
    
    /**
     * Sets the Google API Key
     * @param string $key This should be the Google API Key
     * @return $this
     */
    public function setGoogleAPIKey($key){
        if(is_string($key)){
            $this->google_api_key = $key;
        }
        return $this;
    }
    
    /**
     * Returns the Google API Key
     * @return string The set API key will be returned
     */
    public function getGoogleAPIKey(){
        return $this->google_api_key;
    }
    
    /**
     * Returns information for an individual video
     * @param int $videoID This should be the unique video ID that is assigned in the database
     * @return array|boolean If the video exists will return the video information else will return the information as an array else will return false
     */
    public function getVideoInfo($videoID){
        $videoInfo = self::$db->select($this->video_table, ['id' => $videoID]);
        $videoInfo['information'] = unserialize($videoInfo['information']);
        return $videoInfo;
    }
    
    /**
     * Returns information for an multiple videos and if set will get all videos for a given course
     * @param int|boolean $courseID This should be the course ID that you wish to get all the videos for else set to false to get all videos
     * @return If videos exist they will be returned as a array else will return false
     */
    public function getVideos($courseID = false){
        if(is_numeric($courseID)){
            $where = ['course_id' => $courseID];
        }
        $videos = self::$db->selectAll($this->video_table, $where);
        if(is_array($videos)){
            foreach($videos as $i => $video){
                $videos[$i]['information'] = unserialize($video['information']);
            }
        }
        return $videos;
    }
    
    /**
     * Adds a video and its information to the database
     * @param int $courseID This should be the unique course ID you are assigning the videos to
     * @param string $videoURL This need to be the YouTube video URL
     * @param array $information This should be any additional information in the form of an array with ['fieldname' => $value]; 
     * @return boolean If the video has been successfully added will return true else return false
     */
    public function addVideo($courseID, $videoURL, $information = []){
        $videoID = $this->getVideoIDFromURL($videoURL);
        if($videoID !== false){
            $insert = array_filter(
                array_merge(
                    ['course_id' => intval($courseID), 'video_url' => $videoID],
                    $information,
                    ['information' => serialize($this->getYouTubeInfo($videoID))]
                )
            );
            return self::$db->insert($this->video_table, $insert);
        }
        return false;
    }
    
    /**
     * Edits the video information in the database
     * @param int $videoID This should be the unique video ID in the database
     * @param array $information This should be any information that you wish to update in the form of variable_name => value, any unchanged variable can also be passed
     * @return boolean If the information is updated will return true else will return false
     */
    public function editVideo($videoID, $information = []){
        if($information['video_url']){
            $information = array_filter(
                array_merge(
                    $information,
                    ['information' => serialize($this->getYouTubeInfo($information['video_url']))]
                )
            );
        }
        return self::$db->update($this->video_table, $information, ['id' => $videoID]);
    }
    
    /**
     * Deletes a video from the database
     * @param int $videoID This should be the unique ID given to the video in the database
     * @return boolean If the video information is deleted will return true else return false
     */
    public function deleteVideo($videoID){
        return self::$db->delete($this->video_table, ['id' => $videoID]);
    }
    
    /**
     * Retrieves the YouTube information for a given video URL
     * @param string $videoID This should be the YouTube Video ID
     * @return object If the video exists will return the video information as an object
     */
    protected function getYouTubeInfo($videoID){
        $youTube = new Youtube(['key' => $this->getYouTubeAPIKey()]);
        return $youTube->getVideoInfo($videoID);
    }
    
    /**
     * Returns the YouTube Video ID from a given URL
     * @param string $url This should be the YouTube URL
     * @return string|false The video ID will be returned if it's detected else will return false
     */
    protected function getVideoIDFromURL($url){
        $matches = [];
        preg_match("/^(?:http(?:s)?:\/\/)?(?:www\.)?(?:m\.)?(?:youtu\.be\/|youtube\.com\/(?:(?:watch)?\?(?:.*&)?v(?:i)?=|(?:embed|v|vi|user)\/))([^\?&\"'>]+)/", $url, $matches);
        if(!empty($matches)){
            return $matches[1];
        }
        return false;
    }
}
