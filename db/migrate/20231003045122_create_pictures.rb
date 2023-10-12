class CreatePictures < ActiveRecord::Migration[7.0]
  def change
    create_table :pictures do |t|
      t.text :image, null: false
      t.text :google_drive_url

      t.timestamps
    end
  end
end
