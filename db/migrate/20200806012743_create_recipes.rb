class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :description
      t.string :cuisines, array: true, default: []
      t.json :duration
      t.json :ingredients
      t.json :instructions
      t.integer :user_id
      t.timestamps
    end
    #add index : not sure why
    add_index :recipes, :cuisines, using: 'gin'
    # add_index :recipes, :ingredients, using: 'gin'
    # add_index :recipes, :instructions, using: 'gin'
  end
end
