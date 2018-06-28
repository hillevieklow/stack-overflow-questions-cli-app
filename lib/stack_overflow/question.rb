# Creates Question class
class Question
  # Accessors for question details
  attr_accessor :question, :question_type, :link, :description_short, :description_long, :user

  # Initiates class arrays to empty arrays
  @@all = []

  # Creates new Question Object
  def initialize(questions_hash)
    @question = questions_hash[:question]
    @link = questions_hash[:link]
    @description_short = questions_hash[:description_short]
    @question_type = questions_hash[:type]
    @@all << self
  end

  # Accesses quesitons of type "newest"
  def self.newest
    Question.all.select { |question| question.question_type == "newest"}
  end

  # Accesses quesitons of type "featured"
  def self.featured
    Question.all.select { |question| question.question_type == "featured"}
  end

  # Creates questions from hash of question info
  def self.create(questions_array)
    questions_array.each do |hash|
      self.new(hash)
    end
  end

  # Adds in-dept details to question object
  def add_details(details_hash)
    @user = details_hash[:user]
    @description_long = details_hash[:description_long]
  end

  # Returns all question objects
  def self.all
    @@all
  end

end
