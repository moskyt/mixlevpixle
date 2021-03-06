require_relative './test_helper'

class TestBasic < MiniTest::Unit::TestCase

  def setup
    @mixle = Mixlevpixle::DalliStore.new('mixle_test', :value_max_bytes => 32*1024*1024)
  end

  def teardown
    @mixle.delete('my-obj-here')
  end

  def test_usage_with_block
    # first run
    myobj1 = @mixle.load('my-obj-here', nil) do
      {"a" => "b"}
    end

    # second run
    myobj2 = @mixle.load('my-obj-here', {})
    assert_equal({'a'=>'b'}, myobj2)
  end

  def test_usage
    # first run
    myobj1 = @mixle.load('my-obj-here', {})
    myobj1['a'] = 'b'
    myobj1.mixle

    # second run
    myobj2 = @mixle.load('my-obj-here', {})
    assert_equal({'a'=>'b'}, myobj2)
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