class WatchlistsController < ApplicationController
  before_action :require_user
  before_action :set_watchlist, only: [:show, :edit, :update, :destroy, :add_movie, :remove_movie]
  before_action :require_same_user, only: [:edit, :update, :destroy, :add_movie, :remove_movie]

  def index
    @watchlists = current_user.watchlists
  end

  def show
    @watchlist = Watchlist.includes(:movies, :user).find(params[:id])
  end

  def new
    @watchlist = Watchlist.new
  end

  def create
    @watchlist = current_user.watchlists.build(watchlist_params)
    if @watchlist.save
      redirect_to @watchlist, notice: "Watchlist created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @watchlist.update(watchlist_params)
      redirect_to @watchlist, notice: "Watchlist updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @watchlist.destroy
    redirect_to watchlists_path, notice: "Watchlist deleted"
  end

  def add_movie
    movie = Movie.find(params[:movie_id])
    unless @watchlist.movies.include?(movie)
      @watchlist.movies << movie
      redirect_to @watchlist, notice: "Movie added to watchlist"
    else
      redirect_to @watchlist, alert: "Movie is already in the watchlist"
    end
  end

  def remove_movie
    movie = Movie.find(params[:movie_id])
    @watchlist.movies.delete(movie)
    redirect_to @watchlist, notice: "Movie removed from watchlist"
  end

  private

  def set_watchlist
    @watchlist = Watchlist.find(params[:id])
  end

  def watchlist_params
    params.require(:watchlist).permit(:name, :description, :is_public)
  end

  def require_same_user
    if current_user != @watchlist.user
      flash[:alert] = "You can only manage your own watchlists"
      redirect_to watchlists_path
    end
  end
end