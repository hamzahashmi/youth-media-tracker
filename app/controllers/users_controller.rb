class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_only, :except => :show
  before_action :set_user, only: [:show, :edit, :update, :destroy ]
#http://www.peoplecancode.com/en/tutorials/users-avatars-uploading-images-using-paperclip
  def index
    @users = User.all
  end

  def show
  end

  def update
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, :notice => "User deleted."
  end
  # def suspend
  #   user = User.find(params[:id])
  #   user.suspended = true
  #   user.save!
  #   redirect_to users_path, :notice => "User suspended."
  # end
  private

  def admin_only
    unless user_signed_in? && current_user.admin?
      flash[:alert] = "Access denied."
      go_back
    end
  end

  def secure_params
    params.require(:user).permit(:role,:suspended,:photo)
  end

  def go_back
    #Attempt to redirect
    redirect_to :back
    #Catch exception and redirect to root
    rescue ActionController::RedirectBackError
      redirect_to root_path
   end
   def set_user
     @user = User.find(params[:id])
   end

end
