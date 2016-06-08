num_questions = 0
until num_questions > 0
  puts "How many questions would you like? (Must be a positive integer)"
  num_questions = gets.chomp.to_i
end

question_file = File.open("questions.csv")
questions = question_file.readlines()
qids = []
num_questions.times do
  qids.push(questions[rand(questions.size)].split(",")[4])
end
