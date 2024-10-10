class MoviesController < ApplicationController
  def new
    @the_movie = Movie.new
  end

  def index
    matching_movies = Movie.all

    @list_of_movies = matching_movies.order(created_at: :desc)

    respond_to do |format|
      format.json do
        render json: @list_of_movies 
      end

      format.html
    end
  end

  def show
    @the_movie = Movie.find(params.fetch(:id))
  end

  def create
    @the_movie = Movie.new
    @the_movie.title = params.fetch("query_title")
    @the_movie.description = params.fetch("query_description")

    if @the_movie.valid?
      @the_movie.save
      redirect_to movies_url,  notice: "Movie created successfully."
    else
      render "new"
    end
  end

  def edit
    @the_movie = Movie.find(params.fetch(:id))
  end

  def update
    @the_movie = Movie.find(params.fetch(:id))

    @the_movie.title = params.fetch("query_title")
    @the_movie.description = params.fetch("query_description")

    if @the_movie.valid?
      @the_movie.save
      redirect_to movie_url(@the_movie), notice: "Movie updated successfully."
    else
      redirect_to movie_url(@the_movie), alert: "Movie failed to update successfully." 
    end
  end

  def destroy
    @the_movie = Movie.find(params.fetch(:id))

    @the_movie.destroy

    redirect_to movies_url, notice: "Movie deleted successfully."
  end
end
