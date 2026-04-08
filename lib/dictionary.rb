module Dictionary
  SOURCE_FILE = 'dictionary.txt'

  # Load and filter the list once when the program starts
  # We use a constant so it stays in memory
  WORDS = File.readlines(SOURCE_FILE)
              .map(&:strip)
              .select { |w| w.length.between?(5, 12) }

  def self.random_word
    WORDS.sample
  end
end
