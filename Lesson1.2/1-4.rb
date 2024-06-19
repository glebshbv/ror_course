# 1. Сделать хеш, содержащий месяцы и количество дней в месяце. В цикле выводить те месяцы, у которых количество дней ровно 30
months = {
  "January" => 31,
  "February" => 28,
  "March" => 31,
  "April" => 30,
  "May" => 31,
  "June" => 30,
  "July" => 31,
  "August" => 31,
  "September" => 30,
  "October" => 31,
  "November" => 30,
  "December" => 31
}
months.each { |month, days| puts month if days == 30 }

# 2. Заполнить массив числами от 10 до 100 с шагом 5
array = []
(10..100).each do |n|
  if n % 5 == 0
    array.push(n)
  end
end
puts "New array: #{array}"
# 3. Заполнить массив числами фибоначчи до 100 => Fn = Fn–2 + Fn–1, где F0=0, F1=1, а n — больше или равно 2 и является целым числом.
fibo = [0,1]
number = fibo.last
number_2 = fibo[-2]
number_to_push = number + number_2
while number_to_push <= 100
  number = fibo.last
  number_2 = fibo[-2]
  number_to_push = number + number_2
  fibo.push(number_to_push)
end
puts fibo

# 4. Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

alphabet = ("a".."z").to_a
vowels_hash = {}
def vowels_check(letter)
  ["a", "e", "i", "o", "u", "y"].include?(letter)
end
alphabet.each do |l|
  if vowels_check(l)
    vowels_hash[l] = alphabet.index(l)
  end
end
puts vowels_hash



# 6. Сумма покупок. Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара (может быть нецелым числом). Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп" в качестве названия товара. На основе введенных данных требуетеся:
# Заполнить и вывести на экран хеш, ключами которого являются названия товаров, а значением - вложенный хеш, содержащий цену за единицу товара и кол-во купленного товара. Также вывести итоговую сумму за каждый товар.
# Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".
#
