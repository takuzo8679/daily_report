require 'minitest/autorun'
require_relative '../lib/rgb_conv.rb'

class RgbConvTest < Minitest::Test
  def test_rgb_conv
    assert_equal "#000000", to_hex(0, 0, 0)
    assert_equal "#ffffff", to_hex(255, 255, 255)
    assert_equal "#043c78", to_hex(4, 60, 120)
    assert_equal [0, 0, 0], to_ints('#000000')
    assert_equal [255, 255, 255], to_ints('#ffffff')
    assert_equal [4, 60, 120], to_ints('#043c78')
  end
end

