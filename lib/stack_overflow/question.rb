require 'pry'
class StackOverflow::Question
  attr_accessor :question, :description_short, :description_long, :votes, :answers, :tags

  def self.today
    self.scrape_questions
  end

  def self.scrape_questions
    questions = []
    questions << self.scrape_stack_overflow
    questions
  end

  def self.scrape_stack_overflow
    doc = Nokogiri::HTML(open("https://stackoverflow.com/questions"))
    # binding.pry
    question = self.new
    question.question = doc.css("div#questions.flush-left h3").first.text.strip
    question.description_short = doc.css("div#questions.flush-left .excerpt").first.text.strip
    question
  end
end
