puts "Let's find out surface of the triangle"
sleep 1
puts "What is the base of the triangle?"
base = gets.chomp
puts "What is the height of the triangle?"
height = gets.chomp

surface = 0.5 * base.to_i * height.to_i

puts "The surface of the triangle is #{surface}"
