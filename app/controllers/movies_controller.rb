class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:index, :show]

  def index
    @movies = Movie.all
    
    case params[:sort]
    when "rating"
      @movies = @movies.left_joins(:reviews)
                       .group(:id)
                       .order('AVG(reviews.rating) DESC NULLS LAST')
    when "year"
      @movies = @movies.order(release_year: :desc)
    else
      @movies = @movies.order(created_at: :desc)
    end
    
    # If you're using a pagination plugin, uncomment below
    # @movies = @movies.page(params[:page]).per(12)  # Kaminari
    # or
    # @movies = @movies.paginate(page: params[:page], per_page: 12)  # will_paginate
  end

  def show
    # @movie is already set via before_action :set_movie
    @reviews = @movie.reviews.includes(:user, comments: :user).order(created_at: :desc)
    @review = Review.new  # Add this line to initialize @review
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie added successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie information updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path, notice: "Movie deleted"
  end

  private

  def set_movie
    @movie = Movie.includes(reviews: [:user, comments: :user]).find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :release_year, :director, :cast, :synopsis, :duration, :language, :genres, :poster_image)
  end

  def require_admin
    unless logged_in? && current_user.admin?
      flash[:alert] = "You don't have permission to access this page"
      redirect_to root_path
    end
  end
end