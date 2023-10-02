class InvoicesController < ApplicationController
  def index
  @invoices = Invoice.all
  end

  def new
    @invoice = Invoice.new
  end

  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.save
      redirect_to invoices_path
      flash[:success] = t('notice.task_create')
    else
      flash.now[:danger] = t('flash.create')
      render :new
    end
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  private

  def invoice_params
    params.require(:invoice).permit(:subject, :issued_on, :due_on, :api_status, :memo)
  end
end
