require 'date'
class Enigma
  # only needed for the test
  attr_reader :dictionary

  def initialize
    @dictionary = [*("a".."z"), *("0".."9"), " ", ".", ","]
  end

  def encrypt(message, key = nil, date = Date.today)
    rotation  = add_date_offsets(create_rotations_from_key(validate_key(key)), validate_date(date))

    rotate(message.downcase, rotation)
  end

  def decrypt(message, key, date = Date.today)
    rotation  = add_date_offsets(create_rotations_from_key(validate_key(key)), validate_date(date))
    rotation.map! { |e| e = -e }

    rotate(message.downcase, rotation)
  end

  def crack(message, date = Date.today)
    temp_message = ""
    temp_key = 0
    0.upto(99999) do |key|
      temp_key = key.to_s.rjust(5, "0")
      temp_message = decrypt(message, temp_key, date)
      return temp_message, temp_key if temp_message[-7..-1] == "..end.."
    end
  end

  def validate_date(date)
    if date.class == Date
      date.strftime("%d%m%y").to_i
    elsif date.class == String
      date.to_i
    elsif date.class == Fixnum
      date.to_i
    end
  end

  def validate_key(key)
    if key.nil?
      key = (1..5).map{rand(9)}
    elsif key.class == String
      key = key.chars
    end
  end

  def add_date_offsets(abcd, date)
    offsets = (date*date).to_s[-(abcd.length)..-1]
    0.upto(abcd.length - 1) do |i|
      abcd[i] += offsets[i].to_i
    end
    abcd
  end

  def create_rotations_from_key(key)
    key.each_cons(2).map { |i| i.join.to_i }
  end

  def rotate(message, rotation)
    rotation_index = 0
    message.chars.map do |char|
      rotation_index  = 0 if rotation_index == rotation.length
      new_char        = dictionary[(dictionary.index(char) + rotation[rotation_index]) % 39]
      rotation_index += 1
      new_char
    end.join("")
  end
end

if __FILE__ == $0
  e = Enigma.new
  puts "Initial String"
  puts "some words ..end.."
  puts
  puts "Encrypted"
  puts e.encrypt("some words ..end..", [3,7,2,8,3].join.to_s)
  puts
  puts "Decrypted"
  puts e.decrypt("wogpbwi2hs4jcehoc.", "37283")
  puts
  puts "Cracked"
  puts e.crack("wogpbwi2hs4jcehoc.", Date.today)
end
