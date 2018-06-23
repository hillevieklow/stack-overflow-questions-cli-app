class StackOverflow::CLI
  def call
    list_questions
    menu
    goodbye
  end

  def list_questions
    @questions = StackOverflow::Question.today
    @questions.each.with_index(1) do |question, index|
      puts "#{index}. #{question.question} - #{question.description_short}"
    end
  end

  def menu
    puts "Wohooo"
  end

  def goodbye
    puts "See you later, aligator"
  end
end
