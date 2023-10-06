class RequestorsController < ApplicationController

  def index
    @requestors = Requestor.all
  end

  def new
    @requestor = Requestor.new
  end

  def create
    @requestor = Requestor.new(requestor_params)
    if @requestor.save
      respond_to do |format|
        format.turbo_stream { redirect_to requestors_path, notice: "請求元を登録しました" }
      end
    else
      flash.now[:danger] = "請求元の登録に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def requestor_params
    params.require(:requestor).permit(:name)
  end

end
