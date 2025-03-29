# db/seeds.rb
# Clear existing data (use with caution!)
puts "Clearing existing data..."
Comment.destroy_all
Review.destroy_all
Movie.destroy_all
Watchlist.destroy_all
Profile.destroy_all
User.destroy_all

# Create admin user
puts "Creating users..."
admin = User.create!(
  username: "admin",
  email: "admin@example.com",
  password: "password",
  role: "admin"
)

user1 = User.create!(
  username: "lucy",
  email: "lucy@example.com",
  password: "password"
)

user2 = User.create!(
  username: "jack",
  email: "jack@example.com",
  password: "password"
)

# Update user profiles
puts "Updating user profiles..."
admin.profile.update(
  bio: "I am the site administrator. I love movies and reviews.",
  location: "Beijing",
  favorite_genre: "Sci-Fi, Mystery"
)

user1.profile.update(
  bio: "Movie enthusiast, especially love action movies and comedies.",
  location: "Shanghai",
  favorite_genre: "Action, Comedy"
)

user2.profile.update(
  bio: "Art film lover, also interested in indie movies.",
  location: "Guangzhou",
  favorite_genre: "Drama, Art"
)

# Create movies
puts "Creating movie data..."
movies = [
  {
    title: "The Shawshank Redemption",
    release_year: 1994,
    director: "Frank Darabont",
    cast: "Tim Robbins, Morgan Freeman",
    synopsis: "Two imprisoned men find redemption and friendship over many years. Banker Andy Dufresne is sentenced to life in prison for the murder of his wife and her lover, despite claiming innocence. In prison, he befriends Red, an inmate who can get things. With his intelligence and skills, Andy not only changes prison life but also plans an incredible escape.",
    poster_image: "poster/The_Shawshank_Redemption.jpg",
    duration: 142,
    language: "English",
    genres: "Drama"
  },
  {
    title: "Spirited Away",
    release_year: 2001,
    director: "Hayao Miyazaki",
    cast: "Rumi Hiiragi, Miyu Irino",
    synopsis: "10-year-old Chihiro and her parents accidentally enter the spirit world, and she must find a way to save her parents who have been turned into pigs. Chihiro and her parents go through a strange tunnel and arrive in a magical world. Her parents turn into pigs due to their greed, and Chihiro is forced to work at a bathhouse for spirits to find a way to save them. There, she meets various mysterious characters and gradually grows into a brave and strong girl.",
    poster_image: "poster/Spirited_Away.jpg",
    duration: 125,
    language: "Japanese",
    genres: "Animation, Fantasy, Adventure"
  },
  {
    title: "Inception",
    release_year: 2010,
    director: "Christopher Nolan",
    cast: "Leonardo DiCaprio, Joseph Gordon-Levitt",
    synopsis: "A high-end thief can enter others' dreams through technology to steal ideas, but he faces his most dangerous mission yet. Cobb and his team are professional 'extractors' who can steal secrets from people's minds by sharing dreams. This time, they face a new task: not to steal an idea, but to plant one. This dangerous mission involves multiple layers of dreams, and Cobb must also face his own demons.",
    poster_image: "poster/Inception.jpg",
    duration: 148,
    language: "English",
    genres: "Sci-Fi, Adventure, Action"
  },
  {
    title: "Interstellar",
    release_year: 2014,
    director: "Christopher Nolan",
    cast: "Matthew McConaughey, Anne Hathaway",
    synopsis: "A group of astronauts travel through a wormhole for interstellar travel to find a new home for humanity. In the near future, Earth's resources are depleting, and humans face extinction. Former NASA astronaut Cooper is recruited to join a team to travel through a wormhole to explore new planets that might be suitable for human habitation. In this journey across space and time, he must choose between saving all of humanity and reuniting with his daughter.",
    poster_image: "poster/Interstellar.jpg",
    duration: 169,
    language: "English",
    genres: "Sci-Fi, Adventure, Drama"
  },
  {
    title: "Titanic",
    release_year: 1997,
    director: "James Cameron",
    cast: "Leonardo DiCaprio, Kate Winslet",
    synopsis: 'Aristocratic girl Rose and poor artist Jack fall in love on the Titanic, but this "unsinkable ship" is about to face disaster. Young aristocrat Rose and her mother and fiancé are traveling to America in first class on the Titanic. On the ship, she meets Jack, a poor artist, and they quickly fall in love. However, when this luxury liner hits an iceberg, all passengers face life and death choices.',
    poster_image: "poster/Titanic.jpg",
    duration: 194,
    language: "English",
    genres: "Romance, Disaster, Drama"
  },
  {
    title: "The Truman Show",
    release_year: 1998,
    director: "Peter Weir",
    cast: "Jim Carrey, Laura Linney",
    synopsis: "Truman doesn't know his life is a huge reality TV show. He begins to suspect and searches for the truth. Truman has lived in a giant studio since birth, and his every move is watched by millions of viewers worldwide in real-time. When he begins to doubt his world and tries to escape, he must face a cruel truth that could overturn his entire perception.",
    poster_image: "poster/The_Truman_Show.jpg",
    duration: 103,
    language: "English",
    genres: "Drama, Sci-Fi"
  }
]

# Save movies to database
movies.each do |movie_data|
  Movie.create!(movie_data)
end

# Create reviews
puts "Creating movie reviews..."
Movie.all.each do |movie|
  # First user's reviews
  if [1, 3, 5, 7].include?(movie.id)
    Review.create!(
      user: user1,
      movie: movie,
      content: "This is an excellent movie with engaging plot and outstanding performances. I especially like #{movie.director}'s filming techniques, which perfectly showcase #{movie.cast}'s performances. I discover something new every time I watch it. It's definitely a classic in my book, and I strongly recommend it to everyone!",
      rating: rand(7..10)
    )
  end
  
  # Second user's reviews
  if [2, 4, 6, 8].include?(movie.id)
    Review.create!(
      user: user2,
      movie: movie,
      content: "This movie left a deep impression on me. Director #{movie.director}'s techniques are very unique, and the visuals are beautiful. The pacing is well-managed, with both tense, exciting parts and moving moments. #{movie.cast}'s acting is spot on, creating three-dimensional and authentic characters. Overall, it's an excellent work worth watching multiple times.",
      rating: rand(6..9)
    )
  end
  
  # Admin's reviews
  Review.create!(
    user: admin,
    movie: movie,
    content: "As a film critic, I believe this is one of director #{movie.director}'s representative works. The plot development is tight, and #{movie.cast}'s acting is excellent. The film achieves a high standard in visual effects and music coordination, with sincere and moving emotional expression. Despite some minor flaws, it's still a must-see masterpiece.",
    rating: rand(8..10)
  )
end

# Add replies to some reviews
puts "Creating review comments..."
Review.all.sample(5).each do |review|
  # Add 1-3 replies
  rand(1..3).times do
    user = [admin, user1, user2].sample
    if user != review.user # Ensure users don't reply to their own reviews
      Comment.create!(
        user: user,
        review: review,
        content: ["Completely agree with your view!", "I also really like this movie, especially the plot twists.", "The actors' performances are indeed excellent, especially the protagonist.", "The director's approach is very unique, with rich cinematography.", "I think this rating is fair, it's definitely a good film.", "Thank you for sharing your insights, giving me a new understanding of this movie."].sample
      )
    end
  end
end

# Create watchlists
puts "Creating watchlists..."
# User1's watchlists
watchlist1 = Watchlist.create!(
  user: user1,
  name: "Must-See Classics",
  description: "Classic movies I think every film lover should watch. These films have become essential works in film history due to their plot, acting, or the director's unique perspective.",
  is_public: true
)

watchlist2 = Watchlist.create!(
  user: user1,
  name: "To Watch List",
  description: "Movies I plan to watch soon, including some new releases and classics I missed before.",
  is_public: false
)

# User2's watchlists
watchlist3 = Watchlist.create!(
  user: user2,
  name: "Favorite Movies",
  description: "My favorite movies that I've watched more than once, timeless masterpieces.",
  is_public: true
)

watchlist4 = Watchlist.create!(
  user: user2,
  name: "Art Film Collection",
  description: "A collection of art films, perfect for savoring slowly and experiencing the director's unique perspective and artistic expression.",
  is_public: true
)

# Admin's watchlist
watchlist5 = Watchlist.create!(
  user: admin,
  name: "Annual Recommendations",
  description: "My most recommended movies this year, including new releases and rediscovered classics.",
  is_public: true
)

# Add movies to watchlists
puts "Adding movies to watchlists..."
# Ensure we use movie IDs that actually exist
movie_ids = Movie.pluck(:id)

# Use random actual movie IDs
watchlist1.movies << Movie.find(movie_ids.sample(3))
watchlist2.movies << Movie.find(movie_ids.sample(2))
watchlist3.movies << Movie.find(movie_ids.sample(3))
watchlist4.movies << Movie.find(movie_ids.sample(2))
watchlist5.movies << Movie.find(movie_ids.sample(4))

puts "Seed data creation complete!"
puts "Admin account: admin@example.com / password"
puts "Regular user 1: lucy@example.com / password"
puts "Regular user 2: jack@example.com / password"