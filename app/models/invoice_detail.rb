class InvoiceDetail < ApplicationRecord
  belongs_to :invoice
  validates :subject, presence: true
  validates :unit_price, presence: true
  validates :quantity, presence: true

  def sum_of_price(unit_price, quantity)
    unit_price * quantity
  end
end
