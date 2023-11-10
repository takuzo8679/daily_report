# frozen_string_literal: true

require "minitest/autorun"
require_relative '../lib/rainbowable'

class RainbowableTest < Minitest::Test
  def setup
    Object.include Rainbowable
    # String.include Rainbowable
    # Array.include Rainbowable
  end
  def test_rainbow
    expected = "\e[31mH\e[32me\e[33ml\e[34ml\e[35mo\e[36m,\e[31m \e[32mw\e[33mo\e[34mr\e[35ml\e[36md\e[31m!\e[0m"
    puts result = 'Hello, world!'.rainbow
    assert_equal expected, result

    expected = "\e[31m[\e[32m1\e[33m,\e[34m \e[35m2\e[36m,\e[31m \e[32m3\e[33m]\e[0m"
    puts result = [1, 2, 3].rainbow
    assert_equal expected, result

    puts ({foo: 456, bar:[1, 2, 3]}.rainbow)
    puts (10..20).rainbow
    puts true.rainbow
    puts false.rainbow
    puts nil.rainbow
  end
end
