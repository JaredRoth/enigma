class Enigma
  def encrypt(message, key = nil, date = Time.now)
    key_map = build_key_map
    rotation_index = 0
    key.nil? ? key = (1..5).map{rand(9)} : key = key.chars
    date = date.strftime("%d%m%y").to_i
    rotation = add_date_offsets(build_rotation(key), date)

    message.chars.map do |char|
      rotation_index = 0 if rotation_index == rotation.length
      new_char = key_map[(key_map.index(char) + rotation[rotation_index]) % 39]
      rotation_index += 1
      new_char
    end.join("")
  end

  def add_date_offsets(abcd, date)
    offsets = (date*date).to_s[-(abcd.length)..-1]
    0.upto(abcd.length - 1) do |i|
      abcd[i] += offsets[i].to_i
    end
    abcd
  end

  def build_key_map
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
