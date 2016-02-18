require_relative 'enigma'
handle = File.open(ARGV[0], "r")

encrypted = handle.read.chomp

handle.close

key = ARGV[2]
date = ARGV[3]

e = Enigma.new
decrypted = e.decrypt(encrypted, key, date)

writer = File.open(ARGV[1], "w")
writer.write(decrypted)

writer.close
puts "Created '#{File.basename(ARGV[1])}' with the key #{key} and the date #{date}"
