class AddInvoiceRefToPictures < ActiveRecord::Migration[7.0]
  def change
    add_reference :pictures, :invoice, null: false, foreign_key: true
  end
end
