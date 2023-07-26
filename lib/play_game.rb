require_relative "monkey_patch.rb"

def play_hangman(hangman)
    word_found = hangman.word_found?
    puts "the word has #{hangman.word_pick.size} characters"
    puts hangman.word_guess
    puts
    # puts hangman.word_pick
    while hangman.word_found? ==false && hangman.remaining_turns > 0
        print "Guess a  letter: "
        input = gets.chomp.downcase
        puts
        # puts hangman.word_guess
        break if input =="exit"
        if input =="save"
            hangman.save_game
            break
        end
        if input == hangman.word_pick
            word_found = true
            input.each_char{|char| hangman.replace_char(char)}
            puts
            puts hangman.word_guess.green
            # break
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
        word_found = hangman.word_found?
        # puts hangman.word_guess
    end
    if word_found
        puts 
        puts "Congratulations! You have won the game"
    else
        puts
        puts "Sorry, you lost the game. the word was #{hangman.word_pick.yellow}."
    end
end