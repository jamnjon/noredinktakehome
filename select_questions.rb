num_questions = 0
until num_questions > 0
  puts "How many questions would you like? (Must be a positive integer)"
  num_questions = gets.chomp.to_i
end

question_file = File.open("questions.csv")
questions = question_file.readlines()
question_file.close
questions = questions.slice(1, questions.length - 1)
qids = []
strands = {1 => 0, 2 => 0}
standards = Array.new(6,0)

num_questions.times do
  current_size = qids.size
  until qids.size > current_size
    qid = rand(questions.size)
    current_strand = questions[qid][0].to_i
    current_standard = questions[qid].split(',')[2].to_i - 1
    max, max_idx, min = 0, 0, standards[0]
    standards.each_with_index do |s, idx|
      if s > max
        max_idx = idx
        max = s
      end
      min = s if s < min
    end

    current_qid = questions[qid].split(",")[4]

    if ((strands[1] >= strands[2] && current_strand == 2) ||
      (strands[1] <= strands[2] && current_strand == 1)) &&
      (max == min || standards[current_standard] != standards[max_idx])
      if current_size > 9 || !qids.include?(current_qid)
        qids.push(current_qid)
        strands[current_strand] += 1
        standards[current_standard] += 1
      end
    end
  end
end
difficulties = []
qids.each_with_index do |current, i|
  difficulties.push([questions[current.to_i - 1].split(",")[-1], current])
end

difficulties.sort!
difficulties.each_with_index do |diff, i|
  qids[i] = diff[1]
end
puts qids
