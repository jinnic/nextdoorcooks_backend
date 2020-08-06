class UsersController < ApplicationController
  # when you need to authenticate for most of fn then
  # put before_action in application_controller and use 
  # skip_before_action in users_controller.
  ## skip_before_action :authenticate, only: [:create, :login] ##
  before_action :authenticate, only: [:autologin, :profile]

  def index
    users = User.all
    if users
      render json: users
    else
      render json: {message: "no users available"}
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
      render json: {message: user.errors.full_messages}, status: :bad_request
    end
  end

  def login
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      token = encode_token({ user_id: user.id})
      # render json: user #implicitly run serializer 
      # but when using custom json, need to add User.serializer.nwe(user)
      render json: {user: UserSerializer.new(user), token: token}
    else
      render json: {message: "Invalid username or password"}, status: :unauthorized
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
      avatar: params[:avatar]
    )

    render json: @current_user
  end
end
