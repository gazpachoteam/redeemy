class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.string :name
      t.string :url_image
      t.integer :project_id

      t.timestamps
    end
  end
end
