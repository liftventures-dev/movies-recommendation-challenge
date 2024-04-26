class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    render json: @movies
  end

  def recommendations
    favorite_movies = User.find(params[:user_id]).favorites
    @recommendations = RecommendationEngine.new(favorite_movies).recommendations
    render json: @recommendations
  end

  def user_rented_movies
    @rented = User.find(params[:user_id]).rented
    render json: @rented
  end

  def rent
    user = User.find(params[:user_id])
    movie = Movie.find(params[:id])
    if (movie.available_copies >= 1)
      Movie.transaction do
        movie.available_copies -= 1
        movie.save
        user.rented << movie
      end
      render json: movie
    else
      render json: { error: "There are no available copies for this movie." }, status: :bad_request
    end
  end
end