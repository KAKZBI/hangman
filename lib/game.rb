# require_relative 'dictionary'
require_relative 'exceptions'
require_relative 'game_ui'
require_relative 'save_manager'

class Game
  # include Dictionary
  include GameUi
  include SaveManager
  attr_accessor :dictionary_path, :word_pick, :remaining_turns, :word_guess, :bad_guess, :warning
  def initialize(random_word)
    # @dictionary_path = 'dictionary.txt'
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
  # def run 
  #   show_random_number_info
  #   until word_found? || remaining_turns.zero?
  #     begin
  #       input = get_user_guess
  #       raise ExitGameSignal if input == "exit"
  #       raise SaveGameSignal if input == 'save'
  #       if input == word_pick 
  #         input.each_char{|char| replace_char(char)}
          
  #         # show_guessing_word
  #         show_game_status(word_guess, bad_guess, remaining_turns)
    
  #       elsif input.length > 1
  #         raise InvalidWordLengthError
  #       elsif input.length == 1
  #         raise DuplicateGuessError if bad_guess.include?(input) || word_guess.include?(input)
  #         if word_pick.include?(input)
  #             replace_char(input) 
  #             # show_guessing_word
  #             show_game_status(word_guess, bad_guess, remaining_turns)
  #         else
  #           reduce_remaining_turns
  #           add_bad_char(input)
  #           # show_guessing_word
  #           show_game_status(word_guess, bad_guess, remaining_turns)
  #         end
  #         # if bad_guess.length > 0
  #         #         show_bad_guesses 
  #         #         show_warning(send_warning(@remaining_turns)) unless word_found?
  #         # end
  #       end
  #     rescue InvalidWordLengthError => e 
  #       reduce_remaining_turns
  #       show_error_message(e)
  #       show_guessing_word
  #       show_bad_guesses if bad_guess.length > 0
  #       next
  #     rescue DuplicateGuessError => e  
  #       reduce_remaining_turns
  #       show_error_message(e)
  #       # show_warning(send_warning(@remaining_turns))
  #       # show_guessing_word
  #       # show_bad_guesses if bad_guess.length > 0
  #       show_game_status(word_guess, bad_guess, remaining_turns)
  #       next
  #     end
  #   end
  # end
  # def send_warning(turns)
  #       @warning = {
  #           8=>"Welcome to hangman",
  #           7=>"You still have 7 incorrect guesses",
  #           6=>"You still have 6 incorrect guesses",
  #           5=>"You still have 5 incorrect guesses",
  #           4=>"You still have 4 incorrect guesses",
  #           3=>"Caution. You still have only 3 incorrect guesses".red,
  #           2=>"Only 2 incorrect guesses left".red,
  #           1=>"Last chance".red
  #       }[turns]
  # end
  def run 
    show_initializing_session # Delegated to GameUi

    until word_found? || remaining_turns.zero?
      GameUi.show_game_status(word_guess, bad_guess, remaining_turns)
      
      begin
        input = get_user_guess # Delegated to GameUi
        
        raise ExitGameSignal if input == "exit"
        raise SaveGameSignal if input == "save"

        if input == word_pick 
          input.each_char { |char| replace_char(char) }
          
        elsif input.length > 1
          raise InvalidWordLengthError
          
        elsif input.length == 1
          if bad_guess.include?(input) || word_guess.include?(input)
            raise DuplicateGuessError 
          end

          if word_pick.include?(input)
            replace_char(input)
            show_access_granted # Delegated to GameUi
          else
            reduce_remaining_turns
            add_bad_char(input)
            show_access_denied # Delegated to GameUi
          end
        end

      rescue InvalidWordLengthError, DuplicateGuessError => e
        reduce_remaining_turns
        show_security_alert(e) # Delegated to GameUi
        next 
      end
    end
    
    GameUi.show_game_status(word_guess, bad_guess, remaining_turns)
  end
  def won?
    word_found?
  end
end