class AddIndexesToTables < ActiveRecord::Migration[7.0]
  def change
    add_index :reviews, :movie_id, if_not_exists: true
    add_index :reviews, :user_id, if_not_exists: true
    add_index :comments, :review_id, if_not_exists: true
    add_index :comments, :user_id, if_not_exists: true
    add_index :movies, :title, if_not_exists: true
    add_index :watchlists, :user_id, if_not_exists: true
  end
end