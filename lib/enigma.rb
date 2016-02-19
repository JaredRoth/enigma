require 'date'
class Enigma
  # only needed for the test
  attr_reader :dictionary

  def initialize
    @dictionary = [*("a".."z"), *("0".."9"), " ", ".", ","]
  end

  def encrypt(message, key = nil, date = Date.today)
    rotation  = add_date_offsets(create_rotations_from_key_array(key_to_array(key)), date_to_int(date))

    rotate(message.downcase, rotation)
  end

  def decrypt(message, key, date = Date.today)
    rotation  = add_date_offsets(create_rotations_from_key_array(key_to_array(key)), date_to_int(date))
    rotation.map! { |e| e = -e }

    rotate(message.downcase, rotation)
  end

  def crack(message, date = Date.today)
    0.upto(99999) do |key|
      return decrypt(message, key.to_s.rjust(5, "0"), date), key.to_s.rjust(5, "0")if decrypt(message, key.to_s.rjust(5, "0"), date)[-7..-1] == "..end.."
    end
  end

  def rotate(message, rotation)
    message.chars.each_with_index.map do |char, index|
      dictionary[(dictionary.index(char) + rotation[index % 4]) % 39]
    end.join("")
  end

  def create_rotations_from_key_array(key)
    key.each_cons(2).map { |i| i.join.to_i }
  end

  def add_date_offsets(abcd, date)
    offsets = (date*date).to_s[-(abcd.length)..-1]
    0.upto(abcd.length - 1) do |i|
      abcd[i] += offsets[i].to_i
    end
    abcd
  end

  def date_to_int(date)
    if date.class == Date
      date.strftime("%d%m%y").to_i
    elsif date.class == String
      date.to_i
    elsif date.class == Fixnum
      date.to_i
    end
  end

  def key_to_array(key)
    if key.nil?
      key = (1..5).map{rand(9)}
    elsif key.class == String
      key = key.chars
    elsif key.class == Fixnum
      key = key.to_s.chars
    end
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
