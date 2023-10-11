class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
    # if params[:search].present?
    #   if params[:search]["due_on(1i)"].present? && params[:search]["due_on(2i)"].present? && params[:search]["due_on(3i)"].present?
    #     year = params[:search]["due_on(1i)"]
    #     month = params[:search]["due_on(2i)"]
    #     date = params[:search]["due_on(3i)"]
    #     due_on = Date.parse(year + "-" + month + "-" + date)
    #     @invoices = @invoices.search_by_due_on_date(due_on)
    #   elsif params[:search]["due_on(1i)"].present? && params[:search]["due_on(2i)"].present?
    #     year = params[:search]["due_on(1i)"]
    #     month = params[:search]["due_on(2i)"]
    #     date = "1"
    #     due_on = Date.parse(year + "-" + month + "-" + date)
    #     from = due_on.beginning_of_month
    #     to = due_on.end_of_month
    #     @invoices = @invoices.search_by_due_on_month(from, to)
    #   elsif params[:search]["due_on(1i)"].present?
    #     year = params[:search]["due_on(1i)"]
    #     month = "1"
    #     date = "1"
    #     due_on = Date.parse(year + "-" + month + "-" + date)
    #     from = due_on.beginning_of_year
    #     to = due_on.end_of_year
    #     @invoices = @invoices.search_by_due_on_year(from, to)
    #   end
    #   if params[:search][:subject].present?
    #     @invoices = @invoices.search_by_subject(params[:search][:subject])
    #   end
    #   if params[:search][:requestor_id].present?
    #     requestor_id = params[:search][:requestor_id]
    #     @invoices = @invoices.where(requestor_id: requestor_id)
    #   end
    # end
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
    @invoice.user_id = current_user.id
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
    @subtotal = @invoice.subtotal_price_without_tax
    @total = @invoice.total_price_with_tax
  end

  private

  def invoice_params
    params.require(:invoice).permit(:requestor_id, :subject, :issued_on, :due_on, :api_status, :memo, invoice_details_attributes: [:subject, :quantity, :unit_price, :_destroy, :id], pictures_attributes: [:image, :_destroy, :id])
  end

end
