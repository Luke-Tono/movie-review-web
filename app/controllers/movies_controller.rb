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
    
    # 如果你使用了分页插件，取消下面的注释
    # @movies = @movies.page(params[:page]).per(12)  # Kaminari
    # 或
    # @movies = @movies.paginate(page: params[:page], per_page: 12)  # will_paginate
  end

  def show
    @movie = Movie.includes(reviews: [:user, comments: :user]).find(params[:id])
    @reviews = @movie.reviews.order(created_at: :desc)
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "电影已成功添加"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "电影信息已更新"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path, notice: "电影已删除"
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :release_year, :director, :cast, :synopsis, :duration, :language, :genres)
  end

  def require_admin
    unless logged_in? && current_user.admin?
      flash[:alert] = "您没有权限访问此页面"
      redirect_to root_path
    end
  end
end