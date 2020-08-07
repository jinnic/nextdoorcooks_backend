class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :description
      t.integer :duration, array: true
      t.string :ingredients, array: true
      t.string :instructions, array: true
      t.integer :user_id
      t.timestamps
    end
    #add index : not sure why
    add_index :recipes, :duration, using: 'gin'
    add_index :recipes, :ingredients, using: 'gin'
    add_index :recipes, :instructions, using: 'gin'
  end
end
