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

  # def show_guessing_word
  #   puts "\n#{word_guess.green}\n"
  # end

  # def show_warning(message)
  #   puts message
  # end

  # def show_bad_guesses 
  #   puts "Incorrect guesses: #{bad_guess.yellow}"
  # end

  # def show_error_message(error)
  #   puts "\n#{error.message.red}"
  # end

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
    
    # The Target Word (Spaced out for dramatic effect)
    spaced_word = word_guess.chars.join(" ")
    puts " TARGET LOCK:   ".blue.bold + spaced_word.green.bold
    puts "\n"
    
    # The Intel Failures (Bad Guesses)
    if bad_guess.length > 0
      puts " INTEL FAILURES: ".red.bold + bad_guess.red 
    else
      puts " INTEL FAILURES: ".blue.bold + "None. Perfect execution so far."
    end
    puts "\n"
    
    # The Countdown (Dynamic coloring based on danger level)
    turn_color = case remaining_turns
                 when 6..8 then :green
                 when 3..5 then :yellow
                 else :red
                 end
    
    puts " SECURITY BREACH IN: ".bold + "#{remaining_turns} attempts".send(turn_color)
    puts " ================================================\n".cyan.bold
  end
  def self.show_saved_files_menu(saved_files)
    system('clear') || system('cls')
    puts "\n"
    puts " ================= ARCHIVE RETRIEVAL =================".cyan.bold
    puts "\n"
    print " ⏳ SCANNING DATABANKS".blue
    3.times { print ".".blue; sleep(0.2) }
    puts "\n\n"

    if saved_files.empty?
      puts " [!] No archived sessions found in the mainframe.".red
      puts "\n ===================================================\n".cyan.bold
      return
    end

    # Display each file with a formatted name and timestamp
    saved_files.each_with_index do |file, index|
      # Turns "saves/game_3.txt" into "GAME 3"
      display_name = File.basename(file, ".*").gsub("_", " ").upcase 
      
      # Formats the time perfectly: "2026-04-07 14:30"
      time_saved = File.mtime(file).strftime("%Y-%m-%d %H:%M")

      puts " [#{ (index + 1).to_s.green }] ".bold + 
           "SESSION: ".blue + display_name.ljust(12).bold + 
           " | ".yellow + 
           "ARCHIVED: ".blue + time_saved
    end

    puts "\n ===================================================\n".cyan.bold
    print " Enter session ID to restore, or 'exit' to abort ❯ ".magenta.bold
  end
end