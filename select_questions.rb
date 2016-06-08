num_questions = 0
until num_questions > 0
  puts "How many questions would you like? (Must be a positive integer)"
  num_questions = gets.chomp.to_i
end
