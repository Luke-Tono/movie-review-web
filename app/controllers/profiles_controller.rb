class ProfilesController < ApplicationController
  before_action :require_user
  before_action :set_profile
  before_action :require_same_user

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to user_path(@profile.user), notice: "个人资料已更新"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:bio, :location, :favorite_genre)
  end

  def require_same_user
    if current_user != @profile.user
      flash[:alert] = "您只能编辑自己的个人资料"
      redirect_to root_path
    end
  end
end