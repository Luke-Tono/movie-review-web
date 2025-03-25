class CreateJoinTableWatchlistsMovies < ActiveRecord::Migration[7.0]
  def change
    create_join_table :watchlists, :movies do |t|
      t.index [:watchlist_id, :movie_id]
      t.index [:movie_id, :watchlist_id]
      t.timestamps
    end
  end
end