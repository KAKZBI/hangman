require_relative 'lib/game'
require_relative 'lib/display'
require_relative 'lib/exceptions'
require_relative 'lib/dictionary'

Display.describe_hangman

hangman = nil

begin
  loop do
    random_word = Dictionary.random_word
    user_choice = Display.get_user_choice
    system('clear')

    if %w[1 start].include?(user_choice)
      hangman = Game.new(random_word)
      hangman.run
      hangman.display_results
    elsif %w[2 continue].include?(user_choice)
      hangman = SaveManager.continue_game
      hangman.run
      hangman.display_results
    end
  end
rescue ExitGameSignal
  Display.show_exit_sequence
  exit
rescue PermanentFailureError => e
  Display.show_message(e.message)
  exit
rescue SaveGameSignal
  # 3. Save the game safely
  hangman.save_game if hangman
  Display.show_save_sequence
  exit
end
