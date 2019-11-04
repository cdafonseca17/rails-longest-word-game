require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = [*('A'..'Z')].sample(9)
  end

  def score
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    @results = JSON.parse(open(url).read)
    @letters = params[:letters].split
    @words = params[:word].upcase.split('')
    @score = 0
    @list_score = []
    if (@words & @letters) != @words
      @message = 'Wrong use of letters!'
      @score += -5
      @list_score << @score
    elsif @results['found'] == false
      @message = "Word doesn't exist!"
      @score += -3
      @list_score << @score
    else
      @message = "Eligible for a score!"
      @score += @words.length
      @list_score << @score
    end
    @list_score
  end

# can’t be built out of the original grid
# valid according to the grid, but is not a valid English word
# valid according to the grid and is an English word
end
