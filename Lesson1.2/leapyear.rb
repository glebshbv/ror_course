# 5. Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
# Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным.
# (Запрещено использовать встроенные в ruby методы для этого вроде Date#yday или Date#leap?)
# Алгоритм опредления високосного года: docs.microsoft.com

def leap_year(today_year)
  if today_year % 4 == 0
    if today_year % 100 == 0
      if today_year % 400 == 0
        return true
      else
        return false
      end
    else
      return true
    end
  else
    return false
  end
end

def calulate_months(today_month, leap=false)
  if !leap
    months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    months_total = 0
    months_calc = (1..(today_month-1)).each {|m| months_total += months[m-1]}
    puts "Here"
    return months_calc
  else
    leap_months = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    months_total = 0
    months_calc = (1..(today_month-1)).each {|m| months_total += leap_months[m-1]}
    return months_total
  end
end

def calculate_days(today_day, today_month, today_year)
  total_days = calulate_months(today_month, leap_year(today_year)) + today_day
  return total_days
end

puts "Enter today day"
today_day = gets.chomp.to_i
puts "Enter today month"
today_month = gets.chomp.to_i
puts "Enter today year"
today_year = gets.chomp.to_i

puts "Today is: #{today_day}/#{today_month}/#{today_year}"
sleep(0.5)
result = calculate_days(today_day, today_month, today_year)
puts "from 1st Jan to Today is: #{result} days"
