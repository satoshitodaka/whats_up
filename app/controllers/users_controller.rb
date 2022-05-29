class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.build(user_params)

    if @user.save
      redirect_to login_path, success: 'ユーザーを作成しました'
    else
      flash.now[:danger] = 'ユーザー作成に失敗しました'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username)
  end
end
