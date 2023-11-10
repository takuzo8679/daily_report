def fizz_buzz(n)
  if n % 15 == 0
    "Fizz Buzz"
  elsif n % 3 == 0
    "Fizz" 
  elsif n % 5 == 0
    "Buzz"
  else
    n.to_s
  end 
end

# [*1..15].each do |n|
#   puts fizz_buzz(n)
# end
