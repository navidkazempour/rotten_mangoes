class MoviesController < ApplicationController

  def index
    @movies = Movie.all

    if params[:title].present? || params[:director].present? || params[:runtime_in_minutes].present?
      if params[:runtime_in_minutes] == '1'
        lower_range = 0
        upper_range = 90
      elsif params[:runtime_in_minutes] == '2'
        upper_range = 120
        lower_range = 90
      elsif params[:runtime_in_minutes] == '3'
        lower_range = 120
        upper_range = Movie.maximum("runtime_in_minutes") + 1
      end
      @movies = Movie.where("title LIKE ? OR director LIKE ? OR runtime_in_minutes BETWEEN ? AND ?" , params[:title], params[:director], lower_range,upper_range)
    end

  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movies_path(@movies)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :image, :remote_image_url
    )
  end
end
