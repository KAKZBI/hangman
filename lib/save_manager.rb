require 'yaml'

module SaveManager
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
        puts "Your game will be saved under the name #{File.basename(filename)}"
        File.open(filename, 'w') do |file|
            file.puts saved_game
        end
        saved_game
  end

  def self.load_a_game(game_string)
        hash = YAML.load(game_string)
        # p hash
        game = Game.new(hash[:word_pick])
        # p game
        # game.word_pick = hash[:word_pick]
        game.word_guess = hash[:word_guess]
        game.remaining_turns = hash[:remaining_turns]
        game.bad_guess = hash[:bad_guess]
        game.warning = hash[:warning]
        # p game
        game
  end

  def self.continue_game
    if !Dir.exist?('saved_games') || Dir.children('saved_games').length ==0
      puts "Sorry, there are no saved games"
    else
      puts "Saved games:"
      Dir.children('saved_games').each_with_index do |game, index|
        puts "[#{index + 1}]  #{game}"
      end
      print "Which game do you want to open - select the number ? "
      game_to_load = gets.chomp
      puts
      Dir.children('saved_games').each_with_index do |game, index|
        game_to_load = game if game_to_load.to_i == index + 1
      end
      Dir.chdir('saved_games') do
        hangman_string = File.read(game_to_load)
        game_to_load = load_a_game(hangman_string)
      end
    end
  end
end

