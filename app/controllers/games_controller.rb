require 'open-uri'

class GamesController < ApplicationController

  def new;
    # @letters = []
    # 10.times {@letters << ('A'..'Z').to_a.sample}
  end

  def score
    @word = params[:answer].downcase.strip
    @game = GamesService.new(@word, params[:letters].chars)
    # p params[:letters]
    # p params[:letters].split
    # p @word
    @message = if @game.word_exists? && @game.word_valid?
                 'GG'
               elsif @game.word_exists? && !@game.word_valid?
                 "That's a word, but not from the grid"
               elsif !@game.word_exists? && @game.word_valid?
                 'You gotta guess a word ...'
               else
                 "You're not the sharpest tool in the shed, right?"
               end
    @points = @game.set_points
    session[:score] += @points
    session[:longest_word] = @word if @word.length > session[:longest_word].length && @points != 0
  end
end
