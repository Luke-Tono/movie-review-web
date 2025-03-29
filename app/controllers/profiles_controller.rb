class ProfilesController < ApplicationController
  before_action :require_user
  before_action :set_profile
  before_action :require_same_user

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to user_path(@profile.user), notice: "Profile updated"
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
      flash[:alert] = "You can only edit your own profile"
      redirect_to root_path
    end
  end
end