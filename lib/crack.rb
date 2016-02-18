require_relative 'enigma'
handle = File.open(ARGV[0], "r")

encrypted = handle.read.chomp

handle.close

e = Enigma.new
date = ARGV[2]

decrypted = e.crack(encrypted, date)

writer = File.open(ARGV[1], "w")
writer.write(decrypted[0])

writer.close
puts "Created #{ARGV[1].inspect} with the cracked key #{decrypted[1]} and the date #{date}"
