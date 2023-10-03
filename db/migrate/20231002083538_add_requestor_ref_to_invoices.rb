class AddRequestorRefToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_reference :invoices, :requestor, null: false, foreign_key: true
  end
end
