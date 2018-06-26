# Creates Question class
class Question
  # Accessors for question details
  attr_accessor :question, :link, :description_short, :description_long, :user

  # Initiates class arrays to empty arrays
  @@all = []
  @@newest =[]
  @@featured = []

  # Creates new Question Object
  def initialize(questions_hash)
    @question = questions_hash[:question]
    @link = questions_hash[:link]
    @description_short = questions_hash[:description_short]
    @type = questions_hash[:type]
    if @type.downcase == "newest"
      @@newest << self
    elsif @type.downcase == "featured"
      @@featured << self
    end

    # Makes @@all contain every other element from @@newest and @@featured
    @@all = @@newest.zip(@@featured).flatten

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

  # Returns all question objects of type 'newest'
  def self.newest
    @@newest
  end

  # Returns all question objects of type 'featured'
  def self.featured
    @@featured
  end
  
end
