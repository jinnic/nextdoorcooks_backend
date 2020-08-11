class RecipesController < ApplicationController
  def index
    recipes = Recipe.all
    if recipes
      render json: recipes
    else
      render json: {message: "no recipes available"}
    end
  end

  def create
    recipe = Recipe.create(
      name: params[:name],
      duration: params[:duration],
      description: params[:description],
      ingredients: params[:ingredients],
      instructions: params[:instructions],
      user_id: params[:user_id]
    )

    if recipe.valid?
      render json: recipe, status: :created
    else
      render json: {message: recipe.errors.full_messages}, status: :bad_request
    end
  end

  def update
    
    recipe = Recipe.find(params[:id])
    recipe.update(
      name: params[:name],
      duration: params[:duration],
      description: params[:description],
      ingredients: params[:ingredients],
      instructions: params[:instructions],
      user_id: params[:user_id]
    )
    # recipes = Recipe.all
    render json: recipe
  end

end
