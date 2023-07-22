class Movie < ApplicationRecord
  has_many :favorite_movies
  has_many :users, through: :favorite_movies
  scope :by_genre, ->(genre) { where(genre: genre) }
end
  