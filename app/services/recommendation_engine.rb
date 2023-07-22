class RecommendationEngine
  def initialize(params)
    @user_id = params[:user_id]
  end

  def recommendations
    rented = User.find(@user_id).rented
    favorite_movies = User.find(@user_id).favorites
    movie_titles = favorite_movies.pluck(:title)
    genres = Movie.where(title: movie_titles).pluck(:genre)
    common_genres = genres.group_by{ |e| e }.sort_by{ |k, v| -v.length }.map(&:first).take(3)
    Movie.where(genre: common_genres).where.not(id: rented).order(rating: :desc).limit(10)
  end
end