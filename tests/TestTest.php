<?php
namespace Courses\Tests;

use Courses\Quiz\Test;

class TestTest extends SetUp
{
    protected $quizTest;
    
    public function setUp(): void
    {
        parent::setUp();
        $this->quizTest = new Test($this->db, $this->config);
    }
    
    public function tearDown(): void
    {
        parent::tearDown();
        $this->quizTest = null;
    }
    
    public function testExample()
    {
        $this->markTestIncomplete();
    }
}
