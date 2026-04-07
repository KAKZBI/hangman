require 'colorize'

module GameUi
  
  def show_random_number_info
    puts "The word has #{word_pick.size} characters"
    puts "#{word_guess}\n"
  end

  def get_user_guess
    print "\n Enter decryption key (a-z) or command ❯ ".magenta.bold
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

  # --- New Cinematic Feedback Methods ---

  def show_initializing_session
    system('clear') || system('cls')
    puts "\n"
    puts " --- INITIALIZING SESSION --- ".cyan.bold
    sleep(0.8)
  end

  def show_access_granted
    puts "\n ✔ Access Granted: Key found.".green.bold
    sleep(0.6)
  end

  def show_access_denied
    puts "\n ✗ Access Denied: Invalid key.".red.bold
    sleep(0.6)
  end

  def show_security_alert(error)
    puts "\n ! SECURITY ALERT: #{error.message}".yellow.bold
    puts " Turn penalized for system interference.".yellow
    sleep(1.2)
  end

  # --- The Main Dashboard ---

  def self.show_game_status(word_guess, bad_guess, remaining_turns)
    system('clear') || system('cls')
    puts "\n"
    puts " ================= LIVE SESSION =================".cyan.bold
    puts "\n"
    
    # 1. The Target Word (Spaced out for dramatic effect)
    spaced_word = word_guess.chars.join(" ")
    puts " TARGET LOCK:   ".blue.bold + spaced_word.green.bold
    puts "\n"
    
    # 2. The Intel Failures (Bad Guesses)
    if bad_guess.length > 0
      puts " INTEL FAILURES: ".red.bold + bad_guess.red 
    else
      puts " INTEL FAILURES: ".blue.bold + "None. Perfect execution so far."
    end
    puts "\n"
    
    # 3. The Countdown (Dynamic coloring based on danger level)
    turn_color = case remaining_turns
                 when 6..8 then :green
                 when 3..5 then :yellow
                 else :red
                 end
    
    puts " SECURITY BREACH IN: ".bold + "#{remaining_turns} attempts".send(turn_color)
    puts " ================================================\n".cyan.bold
  end
end