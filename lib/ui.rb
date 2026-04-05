require 'colorize'

module Ui
  def get_user_choice
    max_retries = 3
    valid_choices = ['1', '2', '3', 'start', 'continue', 'exit']
    begin
      puts File.read('choice.txt')
      choice = gets.chomp.downcase
      raise BadGameChoice unless valid_choices.include?(choice)
    rescue BadGameChoice => e
      max_retries -= 1
      puts "#{e.message} - #{max_retries} left"
      retry unless max_retries.zero?
      raise PermanentFailureError 
    end
  end
  def show_random_number_info
    puts "the word has #{word_pick.size} characters"
    puts "#{word_guess}\n"
  end
  def get_user_guess
    print "Guess a  letter: "
    gets.chomp.downcase
  end
end