class RatingsController < ApplicationController
  
  before_action :find_rateable, only: [:create, :update]

  def index
    ratings = Rating.all
    render json: ratings
    
  end
  def create
    rating = Rating.create(
      user_id: params[:user_id],
      rateable: @rateable,
      stars: params[:stars],
      comment: params[:comment]
    )
    
    if rating.valid?
      render json: @rateable , status: :created
    else
      render json: {message: rating.errors.full_messages}, status: :bad_request
    end
  end

  def update
    # byebug
      rating = Rating.find(params[:id])
      rating.update(
        stars: params[:stars],
        comment: params[:comment]
      )
      render json: @rateable
  end

  private
  def find_rateable
    @type = params[:rateable_type].constantize
    @rateable = @type.find(params[:rateable_id])
  end
end
