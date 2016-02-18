require_relative 'enigma'
handle = File.open(ARGV[0], "r")

message = handle.read.chomp

handle.close

key = (1..5).map{rand(9)}.join.to_s
date = Date.today.strftime("%d%m%y").to_i
e = Enigma.new
encrypted = e.encrypt(message, key, date)

writer = File.open(ARGV[1], "w")
writer.write(encrypted)

writer.close
puts "Created '#{File.basename(ARGV[1])}' with the key #{key} and the date #{date}"
