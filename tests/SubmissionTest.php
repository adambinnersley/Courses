<?php
namespace Courses\Tests;

use Courses\Quiz\Submission;

class SubmissionTest extends SetUp
{
    protected $submission;
    
    public function setUp(): void
    {
        parent::setUp();
        $this->submission = new Submission($this->db, $this->config);
    }
    
    public function tearDown(): void
    {
        parent::tearDown();
        $this->submission = null;
    }
    
    public function testExample()
    {
        $this->markTestIncomplete();
    }
}
