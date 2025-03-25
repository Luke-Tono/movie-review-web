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
      redirect_to @watchlist, notice: "观影清单已创建"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @watchlist.update(watchlist_params)
      redirect_to @watchlist, notice: "观影清单已更新"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @watchlist.destroy
    redirect_to watchlists_path, notice: "观影清单已删除"
  end

  def add_movie
    movie = Movie.find(params[:movie_id])
    unless @watchlist.movies.include?(movie)
      @watchlist.movies << movie
      redirect_to @watchlist, notice: "电影已添加到观影清单"
    else
      redirect_to @watchlist, alert: "电影已在观影清单中"
    end
  end

  def remove_movie
    movie = Movie.find(params[:movie_id])
    @watchlist.movies.delete(movie)
    redirect_to @watchlist, notice: "电影已从观影清单中移除"
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
      flash[:alert] = "您只能操作自己的观影清单"
      redirect_to watchlists_path
    end
  end
end