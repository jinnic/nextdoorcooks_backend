class LikesController < ApplicationController
  before_filter :find_liker

  def create
    like = liker.likes.create(params[:comments])
    
  end

  private

  def find_liker
    type = params[:likeable_type].capitalize.constantize
    liker = type.find(params [:likeable_id])
  end
end
