class GamesService

  def initialize(word, letters)
    @word = word
    @letters = letters
    p @letters
  end

  def can_build_word?
    word_up = @word.upcase
    letter_counts = @letters.tally
    word_counts = word_up.chars.tally
    word_counts.all? do |char, count|
      letter_counts[char] && letter_counts[char] >= count
    end
  end

  def word_exists?
    url = "https://dictionary.lewagon.com/#{@word}"
    word_serialized = URI.parse(url).read
    word_info = JSON.parse(word_serialized)
    word_info["found"]
  end

  def word_valid?
    given_letters = @letters.tally
    p given_letters
    word_letters = @word.upcase.chars.tally
    p word_letters
    word_letters.all? { |letter, count| given_letters[letter] && word_letters[letter] >= count }
  end

  def set_points
    @points = if word_valid? && word_exists?
                @word.length
              else
                0
              end
  end
end
