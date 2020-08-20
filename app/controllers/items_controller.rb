class ItemsController < ApplicationController
  before_action :find_imageable, only: [:create]

  def create
    # byebug
    items = []
    errors = []
    params[:items].each_value do |i|
      item = Cloudinary::Uploader.upload(i, :resource_type => :auto) 
      # byebug
      case item["resource_type"]
      when "image"
       data = Item.create(
          image: item["secure_url"],
          caption: item["original_filename"],
          user_id: params[:user_id],
          imageable: @imageable 
        )
        if data.valid?  
          items << data
          data.save
        else 
          errors << data.errors.full_messages
        end
        
      when "video"
        Item.create(
          image: item["secure_url"],
          caption: item["original_filename"],
          user_id: params[:user_id],
          imageable: @imageable 
        )
        if data.valid? 
          items << data
          data.save
        else 
          errors << data.errors.full_messages
        end
      else
        
      end
    end
    render json: @imageable , status: :created
    
    # image = Cloudinary::Uploader.upload(params[:image])
    # # video = Cloudinary::Uploader.upload(params[:video], :resource_type => :video)
    # # , video: video["url"]# 
    # item = Item.create(image: image["url"]), user_id:@current_user
    # render json: item
  end

  def update
    # items = []
    # errors = []
    
    # params["items"].each_value do |i|
    #   item = Cloudinary::Uploader.upload(i, :resource_type => :auto) 

    #   case item["resource_type"]
    #   when "image"
    #    data = Item.create(
    #       image: item["secure_url"],
    #       caption: item["original_filename"],
    #       user_id: params[:user_id],
    #       imageable: @imageable 
    #     )
    #     if data 
    #       items << data
    #     else 
    #       errors << { error: data.errors.full_messages}
    #     end
        
    #   when "video"
    #     Item.create(
    #       image: item["secure_url"],
    #       caption: item["original_filename"],
    #       user_id: params[:user_id],
    #       imageable: @imageable 
    #     )
    #     if data 
    #       items << data
    #     else 
    #       errors << { error: data.errors.full_messages}
    #     end
    #   else
        
    #   end
    #   render json: {items: items, errors: errors}
    # end
    
    
    # image = Cloudinary::Uploader.upload(params[:image])
    # # video = Cloudinary::Uploader.upload(params[:video], :resource_type => :video)
    # # , video: video["url"]# 
    # item = Item.create(image: image["url"]), user_id:@current_user
    # render json: item
  end

  private
  def find_imageable
    @type = params[:imageable_type].constantize
    @imageable = @type.find(params[:imageable_id])
  end
end