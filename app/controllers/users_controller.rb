class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[create new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      respond_to do |format|
        format.turbo_stream { redirect_to invoices_path, notice: "ユーザーの作成に成功しました" }
      end
    else
      flash.now[:alert] = "ユーザーの作成に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end