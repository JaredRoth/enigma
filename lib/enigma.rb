require 'date'
class Enigma
  # only needed for the test
  attr_reader :dictionary

  def initialize
    @dictionary = [*("a".."z"), *("A".."Z"), *("0".."9")," ","!","@","$","%","^","&","*","(",")","[","]",",",".","<",">",";",":","/","?","|"]
  end

  def encrypt(message, key = nil, date = Date.today)
    rotation  = add_date_offsets(create_rotations_from_key_array(key_to_array(key)), date_to_int(date))

    rotate(message, rotation)
  end

  def decrypt(message, key, date = Date.today)
    rotation  = add_date_offsets(create_rotations_from_key_array(key_to_array(key)), date_to_int(date))
    rotation.map! { |e| e = -e }

    rotate(message, rotation)
  end

  def crack(message, date = Date.today)
    0.upto(99999) do |key|
<<<<<<< HEAD
      temp_k = key.to_s.rjust(5, "0")
      temp_m = decrypt(message, temp_k, date)
      return crack_source(temp_m, temp_k) if temp_m[-7..-1] == "..end.."
=======
      return decrypt(message, key.to_s.rjust(5, "0"), date), key.to_s.rjust(5, "0")if decrypt(message, key.to_s.rjust(5, "0"), date)[-7..-1] == "..end.."
>>>>>>> master
    end
  end

  def rotate(message, rotation)
    message.chars.each_with_index.map do |char, index|
      dictionary[(dictionary.index(char) + rotation[index % 4]) % 83]
    end.join('')
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
<<<<<<< HEAD

  def crack_source(message, key)
    if caller.include? "./lib/crack.rb:10:in `<main>'"
      return message, key
    else
      return message
    end
  end
=======
>>>>>>> master
end

if __FILE__ == $0
  e = Enigma.new
  # puts "Initial String"
  # puts "some words ..end.."
  # puts
  # puts "Encrypted"
  # puts e.encrypt("some words ..end..", "37283")
  # puts
  # puts "Decrypted"
  # puts e.decrypt("9jTkwrVxUnm?J|UjJ(", "37283")
  # puts
  # puts "Cracked"
  # puts e.crack("9jTkwrVxUnm?J|UjJ(", Date.today)
  # puts

  # p e.encrypt("words", "12345")
  # p e.encrypt("wOrDs", "12345")
  # p e.encrypt("wOrDs)@*%", "12345")
  # p e.encrypt("words", "99999")


  # works with all except '#' and '\'
  # '#' decrypts as '\#' and '\' sometimes escapes

  # p e.encrypt('!@$%^&*()[],.<>;:/?', "12345")
  # p e.decrypt('?kvIcozMgsDQkwHUoAL', "12345")
  # p "!@$%^&*()[],.<>;:/?"
end
