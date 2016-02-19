require_relative 'lib/enigma'
require 'minitest/autorun'

class EnigmaTest < Minitest::Test
  def test_map_gets_built_on_initialize
    e = Enigma.new

    assert_equal ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", " ", ".", ","], e.dictionary
  end

  def test_add_date_offsets
    e = Enigma.new

    assert_equal [18,29,39,51], e.add_date_offsets([12,23,34,45], 140216)
  end

  def test_create_rotations_from_random_key
    e = Enigma.new

    numbers = (1..5).map{rand(9)}

    assert_equal [[numbers[0],numbers[1]].join.to_i, [numbers[1],numbers[2]].join.to_i, [numbers[2],numbers[3]].join.to_i, [numbers[3],numbers[4]].join.to_i], e.create_rotations_from_key_array(numbers)
  end

  def test_build_rotation_with_specified_digits
    e = Enigma.new

    assert_equal [12,23,34,45], e.create_rotations_from_key_array(e.key_to_array(12345))
  end

  def test_build_rotation_with_specified_string
    e = Enigma.new

    assert_equal [12,23,34,45], e.create_rotations_from_key_array(e.key_to_array("12345"))
  end

  def test_encrypt_with_date_specified
    e = Enigma.new
    assert_equal "berp ", e.encrypt("words", "12345", Date.today)
    assert_equal "berp ", e.encrypt("words", "12345", 180216)
    assert_equal "berp ", e.encrypt("words", "12345", "180216")
  end

  def test_encrypt_without_date
    e = Enigma.new

    assert_equal "berp ", e.encrypt("words", "12345")
  end

  def test_encrypt_message_only
    e = Enigma.new

    refute_equal "words", e.encrypt("words")
  end

  def test_decrypt
    e = Enigma.new

    assert_equal "words", e.decrypt("berp ", "12345")
  end

  def test_decrypt_high_key
    e = Enigma.new

    assert_equal "words", e.decrypt("kce4g", "99999")
  end

  def test_encrpyt_and_decrypt_with_random_key
    e = Enigma.new

    10.times do
      key = (1..5).map{rand(9)}.join
      coded = e.encrypt("words", key)

      assert_equal "words", e.decrypt(coded, key)
    end
  end

  def test_handling_accidental_capitals
    e = Enigma.new

    assert_equal "berp ", e.encrypt("wOrDs", "12345")
  end

  def test_crack_with_and_without_date_in_two_forms
    e = Enigma.new
    coded = e.encrypt("words ..end..", (1..5).map{rand(9)}.join)

    assert_equal "words ..end..", e.crack(coded, Date.today).first
    assert_equal "words ..end..", e.crack(coded, 180216).first
    assert_equal "words ..end..", e.crack(coded).first
  end

  def test_date_to_int_with_Date
    e = Enigma.new
    date = Date.today

    assert_equal Date.today.strftime("%d%m%y").to_i, e.date_to_int(date)
  end

  def test_date_to_int_with_String
    e = Enigma.new
    date = Date.today

    assert_equal Date.today.strftime("%d%m%y").to_i, e.date_to_int(date)
  end

  def test_date_to_int_with_Fixnum
    e = Enigma.new
    date = Date.today

    assert_equal Date.today.strftime("%d%m%y").to_i, e.date_to_int(date)
  end
end
