<?php
namespace Courses\Tests;

use Courses\Documents;

class DocumentsTest extends SetUp
{
    protected $documents;
    
    public function setUp(): void
    {
        parent::setUp();
        $this->documents = new Documents($this->db);
    }
    
    public function tearDown(): void
    {
        parent::tearDown();
        $this->documents = null;
    }
    
    public function testExample()
    {
        $this->markTestIncomplete();
    }
}
