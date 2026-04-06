require_relative 'lib/game'
require_relative 'lib/display'
require_relative 'lib/exceptions'
require_relative 'lib/dictionary'
# require 'pry-byebug'

Display::describe_hangman
loop do
  begin
    random_word = Dictionary::random_word()
    user_choice = Display::get_user_choice
    system('clear')
    # binding.pry
    if user_choice == '1' || user_choice == 'start'
      hangman = Game.new(random_word)
      hangman.run
      hangman.display_results
    elsif user_choice == '2' || user_choice == 'continue'
      hangman = SaveManager::continue_game
      hangman.run
      hangman.display_results
    end
  rescue ExitGameSignal => e  
    Display.show_message("Thanks for playing!")
    exit
  rescue PermanentFailureError => e
    Display::show_message(e.message)
    exit
  # else
  rescue SaveGameSignal => e
    hangman.save_game
    exit
  end
end