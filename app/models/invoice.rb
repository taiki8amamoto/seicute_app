class Invoice < ApplicationRecord
  has_many :invoice_details, dependent: :destroy
  has_many :pictures, dependent: :destroy
  accepts_nested_attributes_for :invoice_details, allow_destroy: true, reject_if: lambda {|attributes| attributes['subject'].blank? and attributes['quantity'].blank? and attributes['unit_price'].blank?}
  accepts_nested_attributes_for :pictures, allow_destroy: true, reject_if: lambda {|attributes| attributes['image'].blank?}
  belongs_to :requestor
  validates :subject, presence: true
  validates :issued_on, presence: true
  validates :due_on, presence: true
  validates :due_on, presence: true
  validates :api_status, presence: true
  enum api_status: { 未連携: 0, 完了: 1 }
end
