# Handles user interface
class CLI
  # Accessing question array
  attr_accessor :questions

  # Straight line used to format output
  @@divider =  "-----------------------------------------------------------------".yellow

  # Starts the program, scrapes stack-overflow and welcomes user
  def start
    Scraper.setup_scrape
    puts "Welcome to Stack Overflow Questions! \u2665".red
    list_questions
  end

  # Lists questions after users choice
  def list_questions
    input = nil
    prompt_user = "Choose either 'newest', 'featured' or 'both'. To exit type 'exit'."
    puts @@divider
    puts prompt_user
    puts @@divider
    input =gets.strip.downcase
    if input == "newest"
      puts "Newest questions: "
      puts @@divider
      @questions = Question.newest
      display_list(@questions)
      menu
    elsif input == "featured"
      puts "Featured questions: "
      @questions = Question.featured
      display_list(@questions)
      menu
    elsif input == "both"
      puts "All questions: "
      @questions = Question.all
      display_list(@questions)
      menu
    elsif input == "exit"
      goodbye
    else
      list_questions
    end
  end

  # Displays list of questions
  def display_list(questions)
    questions.each.with_index(1) do |question, index|
      puts "#{index}. #{question.question}".red
      puts "#{question.description_short}"
      puts @@divider
      break if index == 5
    end
  end

  # Allows user to view questions, switch lists or exit
  def menu
    input = nil
    puts "Enter the number of the question you want to see, type 'list' to choose a new list of quesitons or type 'exit': "
    input = gets.strip.downcase
    if input.to_i > 0 && input.to_i < @questions.length + 1
      question = @questions[input.to_i - 1]
      display_question(question)
    elsif input == "list"
      list_questions
    elsif input == "exit"
      goodbye
    else
      puts "Please make a valid selection."
      menu
    end
  end

  # Displays in-dept information about question
  def display_question(question)
    input = nil
    puts @@divider
    puts "#{question.question}".red
    puts "Asked by: #{question.user}.".red
    puts "#{question.description_long}"
    puts @@divider
    puts "press any key to find another question, or type 'exit'"
    puts @divider
    input = gets.strip.downcase
    if input == "exit"
      goodbye
    else
      list_questions
    end
  end

  # Says goodbye to the user and exits the program 
  def goodbye
    puts "Goodbye!".red
    puts @@divider
  end
end
