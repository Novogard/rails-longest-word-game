require 'open-uri'

class GamesController < ApplicationController
  def new; end

  def score
    session[:rounds_played] += 1
    @word = params[:answer].downcase.strip
    @game = GamesService.new(@word, params[:letters].chars)
    @message = if @game.word_exists? && @game.word_valid?
                 'GG'
                 session[:valid_words_played] += 1
               elsif @game.word_exists? && !@game.word_valid?
                 "That's a word, but not from the grid"
               elsif !@game.word_exists? && @game.word_valid?
                 'You gotta guess a word ...'
                 session[:illiterate_words_played] += 1
               else
                 "You're not the sharpest tool in the shed, right?"
               end
    @points = @game.set_points
    session[:score] += @points
    session[:longest_word] = @word if @word.length > session[:longest_word].length && @points != 0
  end
end
