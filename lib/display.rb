require 'colorize'

module Display 
  def self.describe_hangman
    # puts File.read("describe_hangman.txt")
    system('clear') || system('cls')
    puts "\n"
    # Using double backslashes \\ to escape the characters properly in Ruby strings
    puts " _   _                                         ".cyan.bold
    puts "| | | | __ _ _ __   __ _ _ __ ___   __ _ _ __  ".cyan.bold
    puts "| |_| |/ _` | '_ \\ / _` | '_ ` _ \\ / _` | '_ \\ ".cyan.bold
    puts "|  _  | (_| | | | | (_| | | | | | | (_| | | | |".cyan.bold
    puts "|_| |_|\\__,_|_| |_|\\__, |_| |_| |_|\\__,_|_| |_|".cyan.bold
    puts "                   |___/                       ".cyan.bold
    puts "\n"
    puts "                 A game of survival and logic. \n".italic
    
    puts "=============================================================================".yellow
    puts " THE RULES:".bold.blue
    puts " • " + "The Target : ".bold + "Guess the hidden word (5 to 12 letters)."
    puts " • " + "The Limits : ".bold + "You have 8 incorrect guesses before the game ends."
    puts " • " + "The Tactics: ".bold + "Guess one letter at a time, or risk guessing the whole word."
    puts " • " + "The Control: ".bold + "Type " + "'save'".green + " to pause your game, or " + "'exit'".red + " to abort."
    puts "=============================================================================\n".yellow
  end

  def self.get_user_choice
    max_retries = 3
    valid_choices = ['1', '2', '3', 'start', 'continue', 'exit']
    
    begin
      puts "\n"
      puts " COMMAND CENTER".bold.blue
      puts " [1] ".green + "Start a new game"
      puts " [2] ".yellow + "Continue a saved game"
      puts " [3] ".red + "Exit"
      puts "\n"
      print " Awaiting input ❯ ".cyan.bold 
      
      choice = gets.chomp.downcase
      
      raise BadGameChoice unless valid_choices.include?(choice)
      raise ExitGameSignal if choice == "exit" || choice == '3'
      
    rescue BadGameChoice => e
      max_retries -= 1
      puts " ✗ #{e.message} - #{max_retries} attempts left".red
      retry unless max_retries.zero?
      raise PermanentFailureError
    else
      return choice
    end
  end
  
  def self.show_message(message)
    puts message
  end
end