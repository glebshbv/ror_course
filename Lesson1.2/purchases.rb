# 6. Сумма покупок. Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара (может быть нецелым числом).
# Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп" в качестве названия товара.
# На основе введенных данных требуетеся:
# Заполнить и вывести на экран хеш, ключами которого являются названия товаров, а значением -
# вложенный хеш, содержащий цену за единицу товара и кол-во купленного товара.
# Также вывести итоговую сумму за каждый товар.
# Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".
#
stop_trigger = false
bucket = {}

def add_item(bucket, item_name, item_price, item_amount)
  bucket[item_name] = { "item_price" => item_price, "item_amount" => item_amount }
end

while !stop_trigger
  puts "Enter Item name (or 'stop' to finish):"
  item_name = gets.chomp.to_s
  if item_name.downcase == 'stop'
    stop_trigger = true
    next
  end

  puts "Enter Item price:"
  item_price = gets.chomp.to_f

  puts "Enter Item amount:"
  item_amount = gets.chomp.to_f

  add_item(bucket, item_name, item_price, item_amount)

  puts "Current bucket contents: #{bucket}"
  bucket.each {|key, value| puts "Total for #{key} is: #{value["item_price"] * value["item_amount"]}"}
end

def total_bucket_value(bucket)
  total = 0
  bucket.each do |key, value|
    total += sum(value["item_price"], value["item_amount"])
  end
  return total
end

def sum(price, amount)
  price + amount
end

puts "Final bucket contents: #{bucket}"
puts "Total Bucket Value is: #{total_bucket_value(bucket)}"
