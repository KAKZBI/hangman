require_relative "monkey_patch.rb"

$dictionnary = File.readlines('google-10000-english-no-swears.txt')
$game_dictionnary = $dictionnary.filter{|word| word.size > 5 && word.size <=13}
                                .map{|word| word[0...word.size-1]}#remove the \n at the back

class Game
    attr_accessor :word_pick, :remaining_turns, :word_guess, :bad_guess, :warning
    def initialize
        @word_pick = $game_dictionnary[rand(0...$game_dictionnary.length)]
        @word_guess =Array.new(@word_pick.length, "_")
        @bad_guess = []
        @remaining_turns = 8
        @warning = ""
    end
    def save_game
        saved_game = YAML.dump({
            :word_pick => @word_pick,
            :word_guess => @word_guess,
            :bad_guess => @bad_guess,
            :remaining_turns => @remaining_turns,
            :warning => @warning
        })
        Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
        saved_games_number = Dir.children('saved_games').length
        filename = "saved_games/game_#{saved_games_number+1}.txt"
        puts "Your game will be saved under the name "
        File.open(filename, 'w') do |file|
            file.puts saved_game
        end
        return saved_game
    end
    def self.load_a_game(game_string)
        hash = YAML.load(game_string)
        # p hash
        game = self.new
        # p game
        game.word_pick = hash[:word_pick]
        game.word_guess = hash[:word_guess]
        game.remaining_turns = hash[:remaining_turns]
        game.bad_guess = hash[:bad_guess]
        game.warning = hash[:warning]
        # p game
        return game
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
    def send_warning(turns)
        @warning = {
            8=>"Welcome to hangman",
            7=>"You still have 7 incorrect guesses",
            6=>"You still have 6 incorrect guesses",
            5=>"You still have 5 incorrect guesses",
            4=>"You still have 4 incorrect guesses",
            3=>"Caution. You still have only 3 incorrect guesses".red,
            2=>"Only 2 incorrect guesses left".red,
            1=>"Last chance".red
        }[turns]
        end
    def clear_screen
        system('clear') || system('cls')
    end
end
