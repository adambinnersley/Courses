<?php
namespace Courses\Tests\Quiz;

use PHPUnit\Framework\TestCase;
use Courses\Quiz\Questions;
use DBAL\Database;

class QuestionsTest extends TestCase {
    protected $db;
    protected $questions;
    
    public function setUp() {
        $this->db = new Database($GLOBALS['HOSTNAME'], $GLOBALS['USERNAME'], $GLOBALS['PASSWORD'], $GLOBALS['DATABASE']);
        $this->questions = new Questions($this->db);
    }
    
    public function tearDown() {
        $this->db = null;
        $this->questions = null;
    }
    
    public function testExample() {
        $this->markTestIncomplete();
    }
}
