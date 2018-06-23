class StackOverflow::Question
  attr_accessor :question, :description_short, :description_long, :votes, :answers, :tags

  def self.now
    self.scrape_questions
  end

  def self.scrape_questions
    questions = []
    questions << self.scrape_stack_overflow
    questions
  end

  def self.scrape_stack_overflow
    question = self.new
    question.question = "Example question"
    question
  end
end
