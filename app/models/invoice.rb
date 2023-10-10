class Invoice < ApplicationRecord
  has_many :invoice_details, dependent: :destroy
  has_many :pictures, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :invoice_details, allow_destroy: true, reject_if: lambda {|attributes| attributes['subject'].blank? and attributes['quantity'].blank? and attributes['unit_price'].blank?}
  accepts_nested_attributes_for :pictures, allow_destroy: true, reject_if: lambda {|attributes| attributes['image'].blank?}
  belongs_to :requestor
  validates :subject, presence: true
  validates :issued_on, presence: true
  validates :due_on, presence: true
  validates :due_on, presence: true
  validates :api_status, presence: true
  enum api_status: { 未連携: 0, 完了: 1 }

  def subtotal_price_without_tax
    subtotal = 0
    self.invoice_details.each do |invoice_detail|
      invoice_detail.subject
      quantity = invoice_detail.quantity
      price = invoice_detail.unit_price
      sum = quantity * price
      subtotal += sum
    end
    subtotal
  end

  def total_price_with_tax
    total = 0
    self.invoice_details.each do |invoice_detail|
      invoice_detail.subject
      quantity = invoice_detail.quantity
      price = invoice_detail.unit_price
      subtotal = quantity * price
      total += subtotal
      total
    end
    total = (total * 1.10).floor
  end

end
