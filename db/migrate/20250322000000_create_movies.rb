class CreateMovies < ActiveRecord::Migration[8.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :release_year
      t.string :director
      t.string :cast
      t.text :synopsis
      t.string :poster_image
      t.integer :duration
      t.string :language
      t.string :genres

      t.timestamps
    end
  end
end
