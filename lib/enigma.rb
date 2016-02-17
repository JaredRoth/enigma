require 'date'
class Enigma
  attr_reader :dictionary

  def initialize
    @dictionary = [*("a".."z"), *("0".."9"), " ", ".", ","]
  end

  def encrypt(message, key = nil, date = Date.today)
    date = format_date(date)
    key.nil? ? key = (1..5).map{rand(9)} : key = key.chars
    rotation = add_date_offsets(initial_rotations(key), date)

    rotate(message.downcase, rotation)
  end

  def decrypt(message, key, date = Date.today)
    date = format_date(date)
    rotation = add_date_offsets(initial_rotations(key.chars), date)
    rotation.map! { |e| e = -e }

    rotate(message.downcase, rotation)
  end

  def crack(message, date = Date.today)
    date = format_date(date)

  end

  def format_date(date)
    date.strftime("%d%m%y").to_i
  end

  def add_date_offsets(abcd, date)
    offsets = (date*date).to_s[-(abcd.length)..-1]
    0.upto(abcd.length - 1) do |i|
      abcd[i] += offsets[i].to_i
    end
    abcd
  end

  def initial_rotations(key)
    key.each_cons(2).map do |i|
      i.join.to_i
    end
  end

  def rotate(message, rotation)
    rotation_index = 0
    message.chars.map do |char|
      rotation_index = 0 if rotation_index == rotation.length
      new_char = dictionary[(dictionary.index(char) + rotation[rotation_index]) % 39]
      rotation_index += 1
      new_char
    end.join("")
  end
end

if __FILE__ == $0
  e = Enigma.new
  puts "some words"
  puts e.encrypt("some words", "12345")
  puts e.decrypt(" emqpmo3vi", "12345")
  puts e.crack(" emqpmo3vi")

end
