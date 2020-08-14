class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :image
      t.string :video
      t.string :caption
      t.belongs_to :user
      t.references :imageable, polymorphic: true
      

      t.timestamps
    end
  end
end
