class InvoicesController < ApplicationController
  def index
  @invoices = Invoice.all
  end

  def new
    @invoice = Invoice.new
    5.times {@invoice.invoice_details.build}
    5.times {@invoice.pictures.build}
  end

  def create
    @invoice = Invoice.new(invoice_params)
    # if params[:test_aaa]
    #   requestor = Requestor.create(name: params[:test_aaa])
    #   invoice.requestor_id = requestor.id
    # end
    # if params[:requestor]
    #   requestor = Requestor
    # end
    if @invoice.save
      respond_to do |format|
        format.turbo_stream { redirect_to invoices_path, notice: "請求書を登録しました" }
      end
    else
      flash.now[:danger] = "請求書の登録に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  private

  def invoice_params
    params.require(:invoice).permit(:requestor_id, :subject, :issued_on, :due_on, :api_status, :memo, invoice_details_attributes: [:subject, :quantity, :unit_price, :_destroy, :id], pictures_attributes: [:image, :_destroy, :id])
  end

end
