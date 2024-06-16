puts "Let's solve square equiasion problem"
sleep 1
puts "Enter a: "
a = (gets.chomp).to_i

puts "Enter b: "
b = (gets.chomp).to_i

puts "Enter c: "
c = (gets.chomp).to_i

puts "Checking Discriminant"
sleep 1
d = b ** 2 - (4 * a * c)
puts "Discriminant is #{d}"

abort("No discriminant, end of program")  if d < 0

if d == 0
  x = -b / (2 * a)
  puts "The equation has one real root: x = #{x}"

else
  sqrt_d = Math.sqrt(d)
  x1 = (-b + sqrt_d) / (2 * a)
  x2 = (-b - sqrt_d) / (2 * a)
  puts "The equation has two real roots: x1 = #{x1}, x2 = #{x2}"
end
