class SessionsController < ApplicationController
  skip_before_action :require_login, only: %i[create new]

  def new
  end

  def create
    user = login(params[:email], params[:password])
    if user
      redirect_back_or_to invoices_path
    else
      render :new
    end
  end

  def destroy
    logout
    redirect_to(new_session_path, notice: 'ログアウトしました')
  end

end
