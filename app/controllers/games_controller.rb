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
    if (@words & @letters) != @words
      @message = 'Wrong use of letters!'
    elsif @results['found'] == false
      @message = "Word doesn't exist!"
    else
      @message = "Eligible for a score!"
    end
  end

# can’t be built out of the original grid
# valid according to the grid, but is not a valid English word
# valid according to the grid and is an English word
end
