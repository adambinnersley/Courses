CREATE TABLE IF NOT EXISTS `config` (
  `setting` varchar(100) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`setting`),
  UNIQUE KEY `setting` (`setting`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `config` (`setting`, `value`) VALUES
('table_courses', 'courses'),
('table_course_access', 'course_access'),
('table_course_content', 'course_content'),
('table_course_documents', 'course_documents'),
('table_course_document_group', 'course_doc_groups'),
('table_course_reading', 'course_reading_list'),
('table_course_tests', 'course_tests'),
('table_course_test_answers', 'course_test_user_answers'),
('table_course_test_questions', 'course_test_questions'),
('table_course_test_status', 'course_test_user_status'),
('table_course_user_progress', 'course_content_user_progress'),
('table_course_videos', 'course_videos'),
('table_users', 'users');