    require_relative "game_class.rb"
    require_relative "play_game.rb"
    require 'yaml'

    
    puts File.read("describe_hangman.txt")
    loop do

        puts File.read('choice.txt')
        choice = gets.chomp
        while choice != '1' && choice != '2' && choice != '3'
            system('clear')
            puts File.read('choice.txt')
            choice = gets.chomp
        end
        system('clear')
        exit  unless choice != '3'
        if choice == '1'
            hangman = Game.new
            play_hangman(hangman)
        else
            # hangman = hangman.load_a_game
            # play_game(hangman)
            if !Dir.exist?('saved_games') || Dir.children('saved_games').length ==0
                puts "Sorry, there are no saved games"
            else
                puts "Saved games:"
                Dir.children('saved_games').each_with_index do |game, index|
                    puts "[#{index + 1}]  #{game}"
                end
                print "Which game do you want to open -select the number ? "
                game_to_load = gets.chomp
                puts
                Dir.children('saved_games').each_with_index do |game, index|
                    game_to_load = game if game_to_load.to_i == index + 1
                end
                Dir.chdir('saved_games') do
                    # puts Dir.pwd
                    hangman = File.read(game_to_load)
                    # p hangman
                    # p hangman.class
                    game_to_load = Game.load_a_game(hangman)
                end
                play_hangman(game_to_load) 
            end
        end
    end
    