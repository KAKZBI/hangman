class Dictionary
  def initialize(file_path)
    @file_path = file_path
  end

  def selectable_words
    # readlines gives us an array, strip removes newlines, select filters by length
    File.readlines(@file_path).map(&:strip).select { |word| word.length.between?(5, 12) }
  end

  def random_word
    selectable_words.sample
  end
end