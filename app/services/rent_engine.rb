class RentEngine
  def initialize(params)
    @params = params
  end

  def rent
    user = User.find(@params[:user_id])
    movie = Movie.find(@params[:id])
    movie.available_copies -= 1
    movie.save
    user.rented << movie
    return movie
  end
end