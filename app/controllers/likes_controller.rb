class LikesController < ApplicationController
  before_action :find_likeable, only: [:create]

  def index
    likes = Like.all
    if likes
      render json: likes
    else
      render json: {error: "no likes available"}
    end 
  end

  def create
    like = Like.create(
      user_id: params[:user_id],
      likeable: @likeable
    )
    
    if like.valid?
      render json: @likeable , status: :created
    else
      render json: {error: like.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy
    recipe = Recipe.find(like.likeable_id)
    render json: recipe
  end

  private
  def find_likeable
    @type = params[:likeable_type].constantize
    @likeable = @type.find(params[:likeable_id])
  end

  def find_user
    user = User.find(params[:user_id])
  end
end
