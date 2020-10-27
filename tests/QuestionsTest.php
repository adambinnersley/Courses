<?php
namespace Courses\Tests;

use Courses\Quiz\Questions;

class QuestionsTest extends SetUp
{
    protected $questions;
    
    public function setUp(): void
    {
        parent::setUp();
        $this->questions = new Questions($this->db, $this->config);
    }
    
    public function tearDown(): void
    {
        parent::tearDown();
        $this->questions = null;
    }
    
    public function testExample()
    {
        $this->markTestIncomplete();
    }
}
