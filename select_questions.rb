num_questions = 0
until num_questions > 0
  puts "How many questions would you like? (Must be a positive integer)"
  num_questions = gets.chomp.to_i
end

question_file = File.open("questions.csv")
questions = question_file.readlines()
questions = questions.slice(1, questions.length - 1)
qids = []
strands = {1 => 0, 2 => 0}
num_questions.times do
  current_size = qids.size
  until qids.size > current_size
    qid = rand(questions.size)
    current_strand = questions[qid][0].to_i
    # puts "current_strand: #{current_strand}"
    # puts strands[current_strand]
    if (strands[1] >= strands[2] && current_strand == 2) ||
      (strands[1] <= strands[2] && current_strand == 1)
      puts "inserting #{current_strand}"
      qids.push(questions[qid].split(",")[4])
      strands[current_strand] += 1
    end
  end
end

puts qids
puts strands
