require 'pry'
class Question
  attr_accessor :question, :link, :description_short, :description_long, :votes, :answers, :tags

  @@all = []
  @@newest =[]
  @@featured = []

  def initialize(questions_hash)
    @question = questions_hash[:question]
    @link = questions_hash[:link]
    @description_short = questions_hash[:description_short]
    @type = questions_hash[:type]

    if @type.downcase = "newest"
      @@newest << self
    elsif @type.downcase = "featured"
      @@featured << self
    end
    @@all << self
  end

  def self.create(questions_array)
    questions_array.each do |hash|
      self.new(hash)
    end

  def self.all
    @@all
  end

  def self.newest
    @@newest
  end

  def self.featured
    @@featured
  end
end
