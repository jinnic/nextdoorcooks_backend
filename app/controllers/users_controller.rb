class UsersController < ApplicationController
  # when you need to authenticate for most of fn then
  # put before_action in application_controller and use 
  # skip_before_action in users_controller.
  ## skip_before_action :authenticate, only: [:create, :login] ##
  before_action :authenticate, only: [:autologin, :profile, :follow, :unfollow]

  def index
    users = User.all
    if users
      render json: users
    else
      render json: {error: "no users available"}
    end
  end

  def create
    user = User.create(
      username: params[:username],
      password: params[:password],
      location: params[:location],
      bio: params[:bio],
      avatar: params[:avatar]
    )

    if user.valid?
      # render json: user, status: :created
      # token = JWT.encode({ user_id: user.id}, 'secret_key' ,'HS256')
      token = encode_token({ user_id: user.id})
      render json: {user: UserSerializer.new(user), token: token}, status: :created
    else
      render json: {error: user.errors.full_messages}, status: :bad_request
    end
  end

  def show
    user = User.find(params[:id])
    if user 
        render json: user 
    else 
        render json: { error: "Not found"}, status: 404
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: user
  end

  def update
      user = User.find(params[:id])
      user.update(user_params)
      render json: user
  end

  def following
    user = User.find(params[:id])
    render json: user.followees 
  end

  # def followers
  #   user = User.find_by(username: params[:username])
  #   render json: user.followers
  # end

  def follow
    follow_user = User.find(params[:id])
    @current_user.followees << follow_user
    render json: follow_user
  end

  def unfollow
    unfollow_user = User.find(params[:id])
    # @current_user.followed_users.find_by(followee_id: unfollow_user.id).destroy
    @current_user.followed_users.find_by(followee_id: params[:id]).destroy
    render json: unfollow_user
  end

  def recipes
    user = User.find_by(username: params[:username])
    # render json: {recipes: user.recipes}
    render json: user.recipes 
  end
  
  def find_user
    user = User.find_by(username: params[:username])
    render json: user
  end

  def login
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      token = encode_token({ user_id: user.id})
      # render json: user #implicitly run serializer 
      # but when using custom json, need to add User.serializer.nwe(user)
      render json: {user: UserSerializer.new(user), token: token}
    else
      render json: {error: "Invalid username or password"}, status: :unauthorized
    end

  end

  def autologin
    render json: @current_user
    # PREVIOUS VERSION
    # # get auth header : token
    # auth_header = request.headers['Authorization']
    # token = auth_header.split(' ')[1]

    # #decrypt the tocken
    # # decoded_token = JWT.decode(token,'secret_key', true, { algorithm: 'HS256' }) 
    # decode_token() 
    # user_id = decoded_token[0]["user_id"]
    
     
    # user = User.find_by(id: user_id)
    # if user 
    #   render json: user
    # else
    #   render json: {message: "Not logged in"}, status: :unauthorized
    # end
  end

  def profile
    # byebug
    @current_user.update(
      location: params[:location],
      bio: params[:bio],
      avatar: params[:avatar],
      title: params[:title],
      about: params[:about]
    )

    render json: @current_user
  end
end
