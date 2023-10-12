class InvoicesController < ApplicationController
  before_action :auth_google_drive
  
  def index
    auth_google_drive
    @invoices = Invoice.all.includes(:requestor)
  end

  def new
    @invoice = Invoice.new
    5.times {@invoice.invoice_details.build}
    3.times {@invoice.pictures.build}
  end

  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.user_id = current_user.id
    # if params[:test_aaa]
    #   requestor = Requestor.create(name: params[:test_aaa])
    #   invoice.requestor_id = requestor.id
    # end
    # if params[:requestor]
    #   requestor = Requestor
    # end

    # 画像が選択されている場合
    if params[:invoice][:pictures_attributes]
      file1 = params[:invoice][:pictures_attributes][:"0"][:image]
      files = []
      files << file1
      if params[:invoice][:pictures_attributes][:"1"]
        file2 = params[:invoice][:pictures_attributes][:"1"][:image]
        files << file2
        if params[:invoice][:pictures_attributes][:"2"]
          file3 = params[:invoice][:pictures_attributes][:"2"][:image]
          files << file3
        end
      end
      # 請求書の保存が成功した場合
      if @invoice.save
        # Google Driveへの画像連携処理開始
        # 格納先のフォルダーの存在を確認し、なければ作成する
        top_folder = @drive.file_by_title("請求書")
        if top_folder.file_by_title(params[:invoice]["issued_on(1i)"]+"年")
          seconed_level_folder = top_folder.file_by_title(params[:invoice]["issued_on(1i)"]+"年")
          if seconed_level_folder.file_by_title(params[:invoice]["issued_on(2i)"]+"月")
            third_level_folder = seconed_level_folder.file_by_title(params[:invoice]["issued_on(2i)"]+"月")
          else
            third_level_folder = seconed_level_folder.create_subfolder(params[:invoice]["issued_on(2i)"]+"月")
          end
        else
          seconed_level_folder = top_folder.create_subfolder(params[:invoice]["issued_on(1i)"]+"年")
          third_level_folder = seconed_level_folder.create_subfolder(params[:invoice]["issued_on(2i)"]+"月")
        end
        # 画像ファイルのアップロード処理
        files.each.with_index do |file, index|
          filename = "#{params[:invoice]["issued_on(1i)"]}年#{params[:invoice]["issued_on(2i)"]}月_#{params[:invoice][:subject]}_#{index + 1}"
          file_ext = File.extname(filename)
          file_find = third_level_folder.upload_from_file(File.absolute_path(file), filename, convert: false)
        end
        # Google Driveへの画像連携処理終了
        # picturesテーブルに保存されたレコードをすぐに呼び出して、google_drive_urlカラムを更新する
        pictures = Picture.where(invoice_id: Invoice.last.id)
        pictures.each.with_index do |picture, index|
          filename = "#{params[:invoice]["issued_on(1i)"]}年#{params[:invoice]["issued_on(2i)"]}月_#{params[:invoice][:subject]}_#{index + 1}"
          file_ext = File.extname(filename)
          file = @drive.file_by_title(filename)
          picture.update(google_drive_url: "https://drive.google.com/uc?export=view&id=#{file.id}")
        end
        respond_to do |format|
          format.turbo_stream { redirect_to invoices_path, notice: "請求書を登録しました" }
        end
      # 請求書の保存が失敗した場合
      else
        flash.now[:danger] = "請求書の登録に失敗しました"
        render :new, status: :unprocessable_entity
      end
    # 画像が選択されていない場合
    else
      flash.now[:danger] = "画像選択してください"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @invoice = Invoice.find(params[:id])
    @pictures = Picture.where(invoice_id: params[:id])
    @subtotal = @invoice.subtotal_price_without_tax
    @total = @invoice.total_price_with_tax
  end

  private

  def invoice_params
    params.require(:invoice).permit(:requestor_id, :subject, :issued_on, :due_on, :api_status, :memo, invoice_details_attributes: [:subject, :quantity, :unit_price, :_destroy, :id], pictures_attributes: [:image, :_destroy, :id])
  end

  def auth_google_drive
    client = OAuth2::Client.new(
      ENV['GOOGLE_DRIVE_CLIENT_ID'], ENV['GOOGLE_DRIVE_CLIENT_SECRET'],
      site: 'https://accounts.google.com',
      token_url: '/o/oauth2/token',
      authorize_url: '/o/oauth2/auth'
    )

    @token = OAuth2::AccessToken.from_hash(
      client, { refresh_token: ENV['GOOGLE_DRIVE_REFRESH_TOKEN'], expires_at: 3600 }
    ).refresh!.token

    @drive = GoogleDrive.login_with_oauth(@token)
  end

end
