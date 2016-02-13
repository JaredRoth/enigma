class Enigma
  def encrypt(message, key = (1..5).map{rand(9)}, date = Time.now.strftime("%d%m%y").to_i)
    alphabet_map = build_map
    rotation = build_rotation(key)
    rotation = add_date_offsets(rotation, date)
    rotation = reduce_rotation(rotation)
  end

  def reduce_rotation(array)
    array.map do |i|
      i = i % 38
    end
  end

  def add_date_offsets(array, date)
    offsets = (date*date).to_s[-(array.length)..-1]
    0.upto(array.length - 1) do |i|
      array[i] += offsets[i].to_i
    end
    array
  end

  def build_map
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
