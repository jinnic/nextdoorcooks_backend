class UsersController < ApplicationController
  skip_before_action :require_login, only: [:create, :index]

  def index
      users = User.all
      if users
        render json: users
      else
        render json: {error: "no users available"}
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

  def create 
      user = User.create(user_params)
      if user.valid?
          token = encode_token({user_id: user.id})
          render json: { user: user, token: token }, status: :created
        else
          render json: { error: user.errors.full_messages }, status: 400
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
  
  private

  def user_params
      params.permit(
        username: params[:username],
        password: params[:password],
        location: params[:location],
        bio: params[:bio],
        avatar: params[:avatar]
      )
  end

end
