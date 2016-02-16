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

  def test_build_rotation_with_random_numbers
    e = Enigma.new
    numbers = (1..5).map{rand(9)}

    assert_equal [[numbers[0],numbers[1]].join.to_i, [numbers[1],numbers[2]].join.to_i, [numbers[2],numbers[3]].join.to_i, [numbers[3],numbers[4]].join.to_i], e.initial_rotation(numbers)
  end

  def test_build_rotation_with_specified_numbers
    e = Enigma.new
    assert_equal [12,23,34,45], e.initial_rotation([1,2,3,4,5])
  end

  def test_encrypt_specified
    e = Enigma.new

    assert_equal "berp ", e.encrypt("words", "12345", Time.now)
  end

  def test_encrypt_no_time
    e = Enigma.new

    assert_equal "berp ", e.encrypt("words", "12345")
  end

  def test_encrypt_message_only
    e = Enigma.new

    refute_equal "words", e.encrypt("words")
  end
end
