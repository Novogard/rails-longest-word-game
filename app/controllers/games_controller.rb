require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def can_build_word?(word, letters)
    word_up = word.upcase
    letter_counts = letters.tally
    word_counts = word_up.chars.tally

    word_counts.all? do |char, count|
      letter_counts[char] && letter_counts[char] >= count
    end
  end

  def word_exists?
    url = "https://dictionary.lewagon.com/#{@word}"
    word_serialized = URI.parse(url).read
    word_info = JSON.parse(word_serialized)
    word_info.found
  end

  def word_valid?
    given_letters = @letters.tally
    word_letters = @word.upcase.chars.tally

    word_letters.all? { |letter, count| given_letters[letter] && word_letters[letter] >= count }
  end

  def score
    @word = params[:answer]
    if word_exists? && word_valid?
      'GG'
    elsif word_exists? && !word_valid?
      "That's a word, but not from the grid"
    elsif !word_exists? && word_valid?
      'You gotta guess a word ...'
    else
      "You're not the sharpest tool in the shed, right?"
    end
  end
end
