require 'colorize'

module GameUi
  
  def show_random_number_info
    puts "The word has #{word_pick.size} characters"
    puts "#{word_guess}\n"
  end
  def get_user_guess
    print "Guess a  letter: "
    gets.chomp.downcase
  end
  def show_guessing_word
    puts "\n#{word_guess.green}\n"
  end
  def show_warning(message)
    puts message
  end
  def show_bad_guesses 
    puts "Incorrect guesses: #{bad_guess.yellow}"
  end
  def show_error_message(error)
    puts "\n#{error.message.red}"
  end
  def display_results
    if won?
        puts "\nCongratulations! You have won the game"
    else
        puts "\nSorry, you lost the game. the word was #{word_pick.yellow}."
    end
  end
end