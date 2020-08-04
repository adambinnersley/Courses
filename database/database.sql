--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
CREATE TABLE IF NOT EXISTS `courses` (
  `id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `name` text NOT NULL,
  `description` text,
  `image` mediumtext,
  `image_name` varchar(120) DEFAULT NULL,
  `image_size` int(11) DEFAULT NULL,
  `image_type` varchar(50) DEFAULT NULL,
  `active` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `enrol_learners` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `enrol_pdis` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `enrol_instructors` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `enrol_tutors` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `enrol_individuals` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique course` (`url`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `course_access`
--

DROP TABLE IF EXISTS `course_access`;
CREATE TABLE IF NOT EXISTS `course_access` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `course_id` smallint(6) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED DEFAULT NULL,
  `instructor_id` int(11) UNSIGNED DEFAULT NULL,
  `expiry_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_course` (`course_id`,`user_id`,`is_instructor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `course_content`
--

DROP TABLE IF EXISTS `course_content`;
CREATE TABLE IF NOT EXISTS `course_content` (
  `page_id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `course_id` smallint(6) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` longtext NOT NULL,
  `subof` smallint(6) UNSIGNED DEFAULT NULL,
  `nav_order` decimal(5,3) UNSIGNED NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`page_id`),
  KEY `course_order` (`course_id`,`nav_order`) USING BTREE,
  KEY `subof` (`subof`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `course_content_user_progress`
--

DROP TABLE IF EXISTS `course_content_user_progress`;
CREATE TABLE IF NOT EXISTS `course_content_user_progress` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `is_instructor` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `page_id` smallint(6) UNSIGNED NOT NULL,
  `time_spent` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `last_viewed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_page` (`user_id`,`is_instructor`,`page_id`),
  KEY `page_id` (`page_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `course_documents`
--

DROP TABLE IF EXISTS `course_documents`;
CREATE TABLE IF NOT EXISTS `course_documents` (
  `id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `course_id` smallint(4) UNSIGNED NOT NULL,
  `group_id` smallint(5) UNSIGNED NOT NULL,
  `link_text` varchar(100) DEFAULT NULL,
  `file` varchar(100) NOT NULL,
  `type` varchar(50) NOT NULL,
  `size` int(11) NOT NULL DEFAULT '0',
  `content` mediumblob NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_link` (`course_id`,`file`),
  KEY `course_id` (`course_id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `course_doc_groups`
--

DROP TABLE IF EXISTS `course_doc_groups`;
CREATE TABLE IF NOT EXISTS `course_doc_groups` (
  `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `course_id` smallint(5) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_course_name` (`course_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `course_reading_list`
--

DROP TABLE IF EXISTS `course_reading_list`;
CREATE TABLE IF NOT EXISTS `course_reading_list` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `course_id` smallint(4) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `resource_type` tinyint(4) UNSIGNED NOT NULL,
  `author` varchar(100) DEFAULT NULL,
  `publisher` varchar(100) DEFAULT NULL,
  `publish_date` varchar(20) DEFAULT NULL,
  `isbn` varchar(45) DEFAULT NULL,
  `description` text,
  `link` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_id` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `course_tests`
--

DROP TABLE IF EXISTS `course_tests`;
CREATE TABLE IF NOT EXISTS `course_tests` (
  `test_id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `course_id` smallint(6) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `self_assessed` tinyint(1) UNSIGHNED NOT NULL DEFAULT '0';
  `pass_mark` smallint(6) UNSIGNED DEFAULT NULL,
  `pass_percentage` tinyint(3) UNSIGNED DEFAULT NULL,
  `active` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`test_id`),
  KEY `course_id` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `course_test_questions`
--

DROP TABLE IF EXISTS `course_test_questions`;
CREATE TABLE IF NOT EXISTS `course_test_questions` (
  `question_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `test_id` smallint(6) UNSIGNED NOT NULL,
  `question_order` tinyint(4) UNSIGNED NOT NULL,
  `question` text NOT NULL,
  `answers` text,
  `question_type` tinyint(1) NOT NULL,
  `max_score` tinyint(3) UNSIGNED NOT NULL DEFAULT '1',
  `allow_partial` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `explanation` text,
  PRIMARY KEY (`question_id`),
  UNIQUE KEY `unique_question_order` (`test_id`,`question_order`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `course_test_user_answers`
--

DROP TABLE IF EXISTS `course_test_user_answers`;
CREATE TABLE IF NOT EXISTS `course_test_user_answers` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) UNSIGNED NOT NULL,
  `user_type` tinyint(3) UNSIGNED NOT NULL DEFAULT '1',
  `question_id` int(11) UNSIGNED NOT NULL,
  `answer` text,
  `answer_type` tinyint(3) UNSIGNED DEFAULT '1',
  `score` smallint(6) UNSIGNED NOT NULL DEFAULT '0',
  `marked` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `feedback` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_answer` (`user_id`,`user_type`,`question_id`),
  KEY `question_id` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `course_test_user_status`
--

DROP TABLE IF EXISTS `course_test_user_status`;
CREATE TABLE IF NOT EXISTS `course_test_user_status` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `user_type` tinyint(3) UNSIGNED NOT NULL,
  `test_id` smallint(5) UNSIGNED NOT NULL,
  `score` smallint(5) UNSIGNED NOT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `test_id` (`test_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `course_videos`
--

DROP TABLE IF EXISTS `course_videos`;
CREATE TABLE IF NOT EXISTS `course_videos` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `course_id` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `video_url` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `information` text,
  PRIMARY KEY (`id`),
  KEY `course_id` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for table `course_content`
--
ALTER TABLE `course_content` ADD FULLTEXT KEY `search` (`title`,`content`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `course_access`
--
ALTER TABLE `course_access` ADD CONSTRAINT `course_access_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `course_content`
--
ALTER TABLE `course_content`
    ADD CONSTRAINT `course_content_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `course_content_ibfk_2` FOREIGN KEY (`subof`) REFERENCES `course_content` (`page_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `course_content_user_progress`
--
ALTER TABLE `course_content_user_progress` ADD CONSTRAINT `course_content_user_progress_ibfk_1` FOREIGN KEY (`page_id`) REFERENCES `course_content` (`page_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `course_documents`
--
ALTER TABLE `course_documents`
    ADD CONSTRAINT `course_documents_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    ADD CONSTRAINT `course_documents_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `course_doc_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `course_doc_groups`
--
ALTER TABLE `course_doc_groups` ADD CONSTRAINT `course_doc_groups_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `course_reading_list`
--
ALTER TABLE `course_reading_list` ADD CONSTRAINT `course_reading_list_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `course_tests`
--
ALTER TABLE `course_tests` ADD CONSTRAINT `course_tests_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `course_test_questions`
--
ALTER TABLE `course_test_questions` ADD CONSTRAINT `course_test_questions_ibfk_1` FOREIGN KEY (`test_id`) REFERENCES `course_tests` (`test_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `course_test_user_answers`
--
ALTER TABLE `course_test_user_answers` ADD CONSTRAINT `course_test_user_answers_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `course_test_questions` (`question_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `course_test_user_status`
--
ALTER TABLE `course_test_user_status` ADD CONSTRAINT `course_test_user_status_ibfk_1` FOREIGN KEY (`test_id`) REFERENCES `course_tests` (`test_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `course_videos`
--
ALTER TABLE `course_videos` ADD CONSTRAINT `course_videos_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;