module AddImageable
  # before_action :find_rateable, only: [:create]

  def create_items(recipeObj, imageObj)
    
    find_imageable(recipeObj)
    
    items = []
    errors = []
    
    imageObj.each_value do |i|
      
      item = Cloudinary::Uploader.upload(i, :resource_type => :auto) 
      
      case item["resource_type"]
        when "image"
          data = Item.create(
              image: item["secure_url"],
              caption: item["original_filename"],
              user_id: recipeObj[:user_id],
              imageable: @imageable 
            )
            
          if data.valid?
            items << data
            data.save
          else 
            errors <<  data.errors.full_messages
          end
          
        when "video"
          data = Item.create(
              video: item["secure_url"],
              caption: item["original_filename"],
              user_id: recipeObj[:user_id],
              imageable: @imageable 
            )
          if data.valid? 
            items << data
            data.save
          else 
            errors <<  data.errors.full_messages
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

  private
  def find_imageable(recipeObj)
    # @type = Red.constantize
    @imageable = Recipe.find(recipeObj.id)
  end
  
end