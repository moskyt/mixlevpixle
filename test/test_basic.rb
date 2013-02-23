require_relative './test_helper'

class TestBasic < MiniTest::Unit::TestCase
  
  def test1
    mixle = Mixlevpixle::DalliStore.new('mixle_test')

    myobj = {}
    assert_equal({}, myobj)
    myobj = mixle.load('my-obj-here', myobj)
    assert_equal({}, myobj)
    myobj['a'] = 'b'
    assert_equal({'a'=>'b'}, myobj)
    mixle.save 'my-obj-here', myobj
    assert_equal({'a'=>'b'}, myobj)

    myobj = {}
    assert_equal({}, myobj)
    myobj = mixle.load('my-obj-here', myobj)
    assert_equal({'a'=>'b'}, myobj)
    
    mixle.delete('my-obj-here')
  end
  
  def test2
    mixle = Mixlevpixle::DalliStore.new('mixle_test')

    myobj = mixle.load('my-obj-here', {})
    assert_equal({}, myobj)
    myobj['a'] = 'b'
    assert_equal({'a'=>'b'}, myobj)
    myobj.mixle
    assert_equal({'a'=>'b'}, myobj)

    myobj = {}
    assert_equal({}, myobj)
    myobj = mixle.load('my-obj-here', myobj)
    assert_equal({'a'=>'b'}, myobj)

    mixle.delete('my-obj-here')
  end
  
end