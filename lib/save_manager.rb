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

  # def self.continue_game
  #   if !Dir.exist?('saved_games') || Dir.children('saved_games').length ==0
  #     puts "Sorry, there are no saved games"
  #   else
  #     puts "Saved games:"
  #     Dir.children('saved_games').each_with_index do |game, index|
  #       puts "[#{index + 1}]  #{game}"
  #     end
  #     print "Which game do you want to open - select the number ? "
  #     selected_file = gets.chomp
  #     puts
  #     Dir.children('saved_games').each_with_index do |game, index|
  #       selected_file = game if selected_file.to_i == index + 1
  #     end
  #     Dir.chdir('saved_games') do
  #       hangman_string = File.read(selected_file)
  #       selected_file = load_a_game(hangman_string)
  #     end
  #   end
  # end
  def self.continue_game
    # Fetch and sort the files (newest first)
    saved_files = Dir.glob("saved_games/*.txt").sort_by { |file| File.mtime(file) }.reverse

    GameUi.show_saved_files_menu(saved_files)

    choice = gets.chomp.downcase
    
    raise ExitGameSignal if choice == 'exit'
    
    # Convert input to integer and get the correct file index
    file_index = choice.to_i - 1
    
    if file_index >= 0 && file_index < saved_files.length
      selected_file = saved_files[file_index]
      
      # We just read the file directly since selected_file is "saved_games/game_X.txt"
      hangman_string = File.read(selected_file)
    
      # We return the game object to main.rb
      return load_a_game(hangman_string)
    else
      # If they type a number that doesn't exist, we just restart the menu.
      puts " ✗ Invalid Session ID.".red
      sleep(1)
      continue_game # recursively try again
    end
  end
end

