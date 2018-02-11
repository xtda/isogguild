class UserController < ApplicationController
  before_action :require_login

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)

    @user.password = params[:password]
    if @user.update_attributes(user_params)
      flash[:success] = 'password updated'
      redirect_to root_url
    else
      flash.now[:danger] = 'something broke while updating your password'
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password)
  end
end
