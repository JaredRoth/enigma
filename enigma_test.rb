require "minitest/autorun"
require_relative 'enigma'

class EnigmaTest < Minitest::Test
  def test_add_date_offsets
    e = Enigma.new

    assert_equal [18,29,39,51], e.add_date_offsets([12,23,34,45], 140216)
  end

  def test_build_map
    e = Enigma.new

    assert_equal ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", " ", ".", ","], e.dictionary
  end

  def test_build_rotation
    e = Enigma.new

    assert_equal [12,23,34,45], e.initial_rotation([1,2,3,4,5])
  end

  def test_encrypt
    e = Enigma.new
    words = "words"
    key = "12345"

    assert_equal "berp ", e.encrypt(words, key, Time.now)
  end
end
