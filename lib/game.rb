require_relative 'dictionnary'
require_relative 'errors'
require_relative 'ui'

class Game
  include Dictionary
  include Ui
  attr_accessor :dictionary_path, :word_pick, :remaining_turns, :word_guess, :bad_guess, :warning
  def initialize
    @dictionary_path = 'dictionary.txt'
    @word_pick = random_word
    @word_guess =Array.new(@word_pick.length, "_")
    @bad_guess = []
    @remaining_turns = 8
    @warning = ""
  end

  def word_guess
    @word_guess.join("")
  end
  def reduce_remaining_turns
    @remaining_turns -= 1
  end
  def bad_guess
    @bad_guess.join(' ')
  end
  def word_found?
    self.word_guess == @word_pick
  end
  def replace_char(char)
    for i in 0...@word_guess.length
      @word_guess[i] = char if @word_pick[i] == char
    end
  end
  def add_bad_char(char)
    @bad_guess.push(char) unless @bad_guess.include?(char)
  end
  def run 
    show_random_number_info
    until word_found? || remaining_turns.zero?
      input = get_user_guess
      break if input == "exit"
      # if input == "save"
      #   save_game
      #   break
      # end
      
      if input == word_pick
        
        input.each_char{|char| replace_char(char)}
        
        puts hangman.word_guess.green
   
      elsif input.length > 1
        rest = hangman.reduce_remaining_turns
        puts "Invalid answer"
        puts
        puts hangman.word_guess.green
        puts 
        puts "Incorrect guesses: #{hangman.bad_guess.yellow}" if hangman.bad_guess.length > 0    
        puts hangman.send_warning(rest)
      else
        if hangman.word_pick.include?(input)
                hangman.replace_char(input) 
                # hangman.clear_screen
                puts 
                puts hangman.word_guess.green
                puts
                # p "incorrect guesses: #{hangman.bad_guess}"
            else
                rest = hangman.reduce_remaining_turns
                hangman.add_bad_char(input)
                puts 
                puts hangman.word_guess.green
                puts
                
            end
            if hangman.bad_guess.length > 0
                puts "Incorrect guesses: #{hangman.bad_guess.yellow}" 
                puts hangman.send_warning(rest) unless hangman.word_found?
            end
            
            puts
        end
    end
  end
end
g = Game.new
puts g.word_pick
p g.word_guess
g.get_user_choice