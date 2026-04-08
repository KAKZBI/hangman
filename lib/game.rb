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
    @word_guess = Array.new(@word_pick.length, '_')
    @bad_guess = []
    @remaining_turns = 8
    @warning = ''
  end

  def word_guess
    @word_guess.join('')
  end

  def reduce_remaining_turns
    @remaining_turns -= 1
  end

  def bad_guess
    @bad_guess.join(' ')
  end

  def word_found?
    word_guess == @word_pick
  end

  def replace_char(char)
    @word_pick.each_char.with_index do |target_char, index|
      @word_guess[index] = char if target_char == char
    end
  end

  def add_bad_char(char)
    @bad_guess.push(char) unless @bad_guess.include?(char)
  end

  def run
    show_initializing_session

    until word_found? || remaining_turns.zero?
      GameUi.show_game_status(word_guess, bad_guess, remaining_turns)

      begin
        input = get_user_guess

        raise ExitGameSignal if input == 'exit'
        raise SaveGameSignal if input == 'save'

        if input == word_pick
          input.each_char { |char| replace_char(char) }

        elsif input.length > 1
          raise InvalidWordLengthError

        elsif input.length == 1
          raise DuplicateGuessError if bad_guess.include?(input) || word_guess.include?(input)

          if word_pick.include?(input)
            replace_char(input)
            show_access_granted
          else
            reduce_remaining_turns
            add_bad_char(input)
            show_access_denied
          end
        end
      rescue InvalidWordLengthError, DuplicateGuessError => e
        reduce_remaining_turns
        show_security_alert(e)
        next
      end
    end

    GameUi.show_game_status(word_guess, bad_guess, remaining_turns)
  end

  def won?
    word_found?
  end
end