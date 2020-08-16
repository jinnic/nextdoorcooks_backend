class CreateExperiances < ActiveRecord::Migration[6.0]
  def change
    create_table :experiances do |t|
      t.string :title
      t.string :description
      t.string :cuisines, array: true, default: []
      t.integer :durationMin
      t.integer :size
      t.datetime :dates, array: true
      t.integer :user_id
      t.timestamps
    end
    add_index :experiances, :dates, using: 'gin'
    add_index :experiances, :cuisines, using: 'gin'
  end
end
