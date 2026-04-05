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
end

g = Game.new
puts g.word_pick
p g.word_guess