module Dictionary
  def selectable_words
    File.readlines(@dictionary_path).map(&:strip).select { |word| word.length.between?(5, 12) }
  end

  def random_word
    selectable_words.sample
  end
end
