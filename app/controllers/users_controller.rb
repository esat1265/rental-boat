class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
 end

 def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      redirect_to dashboard_path, notice: "Profile updated"
    else
      render :new, status: :unprocessable_entity
      redirect_to dashboard_path
    end
 end
  private

   def user_params
    params.require(:user).permit(:email)
   end
end
