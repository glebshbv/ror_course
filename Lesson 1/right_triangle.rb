puts "Let's find out if your triangle is right angled or not"
sleep 1
puts "Enter side a:"
a = gets.chomp
puts "Enter side b:"
b = gets.chomp
puts "Enter side c:"
c = gets.chomp

triangle_array = [a, b, c]
two_sides_array = [a, b, c]
hypotenuse_index = triangle_array.index(triangle_array.max)
hypotenuse = triangle_array[hypotenuse_index]
triangle_array.delete_at(hypotenuse_index)

if two_sides_array.uniq.length == 1
  puts "All 3 sides of triangle is equal"
elsif hypotenuse**2 == triangle_array.map { |n| n**2 }.sum
  puts "This triangle is a right triangle"
elsif two_sides_array.uniq.length != two_sides_array.length
  puts "This triange has 2 equal sides"
else
  puts "It is a normal triangle"
end
