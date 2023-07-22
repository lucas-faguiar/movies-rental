class RecommendationEngine
  def initialize(params)
    @user_id = params[:user_id]
  end

  def recommendations
    user = User.find(@user_id)
    rented = user.rented
    genres = Movie.where(id: user.favorites).pluck(:genre)
    common_genres = genres.group_by{ |e| e }.sort_by{ |k, v| -v.length }.map(&:first).take(3)
    Movie.by_genre(common_genres).where.not(id: rented).order(rating: :desc).limit(10)
  end
end