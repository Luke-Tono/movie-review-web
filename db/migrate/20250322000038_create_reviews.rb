class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.text :content, null: false
      t.integer :rating, null: false, limit: 1
      
      t.timestamps
    end

    add_index :reviews, [:user_id, :movie_id], unique: true
  end
end