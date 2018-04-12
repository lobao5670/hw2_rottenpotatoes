class MoviesController < ApplicationController
  def self.set_ratings
    @all_ratings = Array.new(['G','PG','PG-13','R','NC-17'])
  end

  def index
    @all_ratings = ['G','PG','PG-13','R','NC-17']
    @movies = Movie.all
    sort = params[:sort_by]
    @movies = Movie.order(sort)
    rating_filter = params[:ratings]
    if (rating_filter != nil)
      @movies = Movie.where(rating: rating_filter.keys).all
    end
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.html.haml by default
  end

  def new

  end

  def create
    @movie = Movie.create!(movie_params)
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  def movie_params
    params.require(:movie).permit(:title, :rating, :release_date)
  end
end
