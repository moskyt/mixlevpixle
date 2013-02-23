require_relative './test_helper'

class TestTimestamps < MiniTest::Unit::TestCase
  
  def setup
    @mixle = Mixlevpixle::DalliStore.new('mixle_test')
  end
  
  def teardown
    @mixle.delete('my-obj-here')
  end
  
  def test_without_timestamping
    bval = 'b'; btime = Time.now
    myobj = @mixle.load('my-obj-here', {})
    myobj['a'] ||= bval
    myobj.mixle
    assert_equal({'a'=>'b'}, myobj)

    sleep 0.1
    myobj = nil

    bval = 'bb'; btime = Time.now
    myobj = @mixle.load('my-obj-here', {})
    myobj['a'] ||= bval
    myobj.mixle
    assert_equal({'a'=>'b'}, myobj)
  end

  def test_with_timestamping
    bval = 'b'; btime = Time.now
    myobj = @mixle.load('my-obj-here', {}, btime)
    myobj['a'] ||= bval
    myobj.mixle
    assert_equal({'a'=>'b'}, myobj)

    sleep 0.1
    myobj = nil

    bval = 'bb'; btime = Time.now
    myobj = @mixle.load('my-obj-here', {}, btime)
    myobj['a'] ||= bval
    myobj.mixle
    assert_equal({'a'=>'bb'}, myobj)
  end

end