<?php
namespace Courses\Tests\Quiz;

use PHPUnit\Framework\TestCase;
use Courses\Quiz\Test;
use DBAL\Database;

class TestTest extends TestCase
{
    protected $db;
    protected $config;
    protected $quizTest;
    
    public function setUp(): void
    {
        $this->db = new Database($GLOBALS['HOSTNAME'], $GLOBALS['USERNAME'], $GLOBALS['PASSWORD'], $GLOBALS['DATABASE']);
        $this->config = new Config($this->db);
        $this->quizTest = new Test($this->db, $this->config);
    }
    
    public function tearDown(): void
    {
        $this->db = null;
        $this->quizTest = null;
    }
    
    public function testExample()
    {
        $this->markTestIncomplete();
    }
}
