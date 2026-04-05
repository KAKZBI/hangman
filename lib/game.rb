require_relative 'dictionnary'
require_relative 'errors'

class Game
  include Dictionary
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
end

g = Game.new
puts g.word_pick
p g.word_guess