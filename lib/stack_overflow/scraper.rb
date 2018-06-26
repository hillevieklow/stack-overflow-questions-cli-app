# Scraper class scrapes questions from www.stackoverflow.com

class Scraper

  @@url_featured = "https://stackoverflow.com/questions?sort=featured"
  @@url_newest = "https://stackoverflow.com/questions?sort=newest"

  # initiate the scrape
  def self.setup_scrape
    Question.create(self.scrape_newest)
    Question.create(self.scrape_featured)
    Question.all.each do |question|
      details = self.scrape_question_details(question.link)
      question.add_details(details)
    end
  end

  # Scrapes newest questions
  def self.scrape_newest
    doc = Nokogiri::HTML(open(@@url_newest))
    questions = []
    doc.css("div#questions.flush-left").each do |question|
      question.css(".question-summary").each do |q|
        question = q.css("h3").text
        description_short = q.css(".excerpt").text.strip
        stack_link = q.css("h3 a").attr("href")
        link = "https://stackoverflow.com" + stack_link
        type = "newest"
        questions << {:question => question, :description_short => description_short, :link => link, :type => type}
      end
    end
    questions
  end

  # Scrapes featured questions
  def self.scrape_featured
    doc = Nokogiri::HTML(open(@@url_featured))
    questions = []
    doc.css("div#questions.flush-left").each do |question|
      question.css(".question-summary").each do |q|
        question = q.css("h3").text
        description_short = q.css(".excerpt").text.strip
        stack_link = q.css("h3 a").attr("href")
        link = "https://stackoverflow.com" + stack_link
        type = "featured"
        questions << {:question => question, :description_short => description_short, :link => link, :type => type}
      end
    end
    questions
  end

  # Scrapes in-dept details of question by using question_url obtained in above scraping methods
  def self.scrape_question_details(question_url)
    doc = Nokogiri::HTML(open(question_url))
    question_data = {}
    question_data[:user] = doc.css("div.user-details a").text
    question_data[:description_long] = doc.css("div.post-text").text.strip
    question_data
  end

end
