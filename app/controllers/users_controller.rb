class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Registration successful, welcome!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.includes(:profile).find(params[:id])
    @reviews = @user.reviews.includes(:movie).order(created_at: :desc)
    @watchlists = @user == current_user ? 
                  @user.watchlists.includes(:movies) : 
                  @user.watchlists.where(is_public: true).includes(:movies)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User information updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :avatar)
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit your own account"
      redirect_to root_path
    end
  end
end