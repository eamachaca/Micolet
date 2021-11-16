class PagesController < ApplicationController
  def homepage
    @user = User.new
    @preferences = Preference.all
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    @preferences = Preference.all
    if @user.save
      prefers = params.require(:preferences)

      redirect_to root_url, notice: "User was successfully created."
    else
      render :homepage
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email )
  end
end
