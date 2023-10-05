class AddIndexToRequestorsName < ActiveRecord::Migration[7.0]
  def change
    add_index :requestors, :name, unique: true
  end
end
