puts "What is your name? "
name = gets.chomp
puts "What is your height?"
height = gets.chomp
ideal_weight = (height.to_i - 110) * 1.15
if ideal_weight > 0
  puts "Hi, #{name}! Your ideal weight is #{ideal_weight}"
else
  puts "Hi, #{name}! Your weight is already optimal"
end
