class UsersController < ApplicationController
  before_action :admin?

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      respond_to do |format|
        format.turbo_stream { redirect_to users_path, notice: "ユーザーの作成に成功しました" }
      end
    else
      flash.now[:alert] = "ユーザーの作成に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])

  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      respond_to do |format|
        format.turbo_stream { redirect_to users_path, notice: "ユーザーを更新しました" }
      end
    else
      flash.now[:danger] = "ユーザーの更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      respond_to do |format|
        format.turbo_stream { redirect_to users_path, notice: "ユーザーを削除しました", status: :see_other }
      end
    else
      respond_to do |format|
        format.turbo_stream { redirect_to users_path, notice: "ユーザーの削除に失敗しました", status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end

  def admin?
    unless current_user.role == "管理者"
      flash[:danger] = "許可されていないアクセスです"
      redirect_to invoices_path
    end
  end
end