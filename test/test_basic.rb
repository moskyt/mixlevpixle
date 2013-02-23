require_relative './test_helper'

class TestBasic < MiniTest::Unit::TestCase
  
  def setup
    @mixle = Mixlevpixle::DalliStore.new('mixle_test')
  end
  
  def teardown
    @mixle.delete('my-obj-here')
  end
  
  def test1
    myobj = {}
    assert_equal({}, myobj)
    myobj = @mixle.load('my-obj-here', myobj)
    assert_equal({}, myobj)
    myobj['a'] = 'b'
    assert_equal({'a'=>'b'}, myobj)
    @mixle.save 'my-obj-here', myobj
    assert_equal({'a'=>'b'}, myobj)

    myobj = {}
    assert_equal({}, myobj)
    myobj = @mixle.load('my-obj-here', myobj)
    assert_equal({'a'=>'b'}, myobj)
  end
  
  def test2
    myobj = @mixle.load('my-obj-here', {})
    assert_equal({}, myobj)
    myobj['a'] = 'b'
    assert_equal({'a'=>'b'}, myobj)
    myobj.mixle
    assert_equal({'a'=>'b'}, myobj)

    myobj = {}
    assert_equal({}, myobj)
    myobj = @mixle.load('my-obj-here', myobj)
    assert_equal({'a'=>'b'}, myobj)
  end
  
end