class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.string :title,               null: false
      t.string :image_content
      t.string :video_content
      t.text :overview,              null: false
      t.text :writing,               null: false
      t.string :source,              null: false
      t.references :user,     foreign_key: true
      t.timestamps
    end
  end
end
