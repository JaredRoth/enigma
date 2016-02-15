class Enigma
  def encrypt(message, key = (1..5).map{rand(9)}, date = Time.now)
    cypher = build_cypher
    rotation_index = 0
    date = date.strftime("%d%m%y").to_i
    rotation = add_date_offsets(build_rotation(key), date)
    message.chars.map do |char|
      rotation_index = 0 if rotation_index == rotation.length
      new_char = cypher[(cypher.index(char) + rotation[rotation_index]) % 39]
      rotation_index += 1
      new_char
    end.join("")
  end

  def add_date_offsets(rotation, date)
    offsets = (date*date).to_s[-(rotation.length)..-1]
    0.upto(rotation.length - 1) do |i|
      rotation[i] += offsets[i].to_i
    end
    rotation
  end

  def build_cypher
    local_map = ("a".."z").to_a
    ("0".."9").to_a.each do |i|
      local_map << i
    end
    local_map << " " << "." << ","
  end

  def build_rotation(key)
    key.each_cons(2).map do |i|
      i.join.to_i
    end
  end
end
e = Enigma.new
p e.encrypt("words", [1,2,3,4,5], Time.now)
