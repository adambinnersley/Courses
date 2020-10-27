<?php
namespace Courses\Tests;

use Courses\Pupils;

class PupilsTest extends SetUp
{
    protected $pupils;
    
    public function setUp(): void
    {
        parent::setUp();
        $this->pupils = new Pupils($this->db, $this->config);
        
    }
    
    public function tearDown(): void
    {
        parent::tearDown();
        $this->pupils = null;
    }
    
    public function testExample()
    {
        $this->markTestIncomplete();
    }
}
