class LikesController < ApplicationController
  # before_action :find_liker
  def index
    likes = Like.all
    if likes
      render json: likes
    else
      render json: {message: "no likes available"}
    end 
  end

  def create
    like = liker.likes.create(params[:comments])
    
  end

  private

  def find_liker
    type = params[:likeable_type].capitalize.constantize
    liker = type.find(params [:likeable_id])
  end
end
