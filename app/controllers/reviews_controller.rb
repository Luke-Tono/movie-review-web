class ReviewsController < ApplicationController
  before_action :require_user
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def create
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to movie_path(@movie), notice: "Review posted"
    else
      @reviews = @movie.reviews.includes(:user).order(created_at: :desc)
      render 'movies/show', status: :unprocessable_entity
    end
  end

  def edit
    @movie = @review.movie
  end

  def index
    @movie = Movie.find(params[:movie_id])
    @reviews = @movie.reviews.includes(:user, comments: :user).order(created_at: :desc)
  end

  def update
    if @review.update(review_params)
      redirect_to movie_path(@review.movie), notice: "Review updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    movie = @review.movie
    @review.destroy
    redirect_to movie_path(movie), notice: "Review deleted"
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def require_same_user
    if current_user != @review.user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own reviews"
      redirect_to movie_path(@review.movie)
    end
  end
end