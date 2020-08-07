class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.integer :stars
      t.string :comment
      t.integer :rateable_id
      t.string :rateable_type
      t.integer :user_id
      t.timestamps
    end
    add_index :ratings, [:rateable_type, :rateable_id]
    # add_index :ratings, :comment, using: 'gin'
    #Ex:- add_index("admin_users", "username")
  end
end
