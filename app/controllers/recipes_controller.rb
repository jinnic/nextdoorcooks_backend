class RecipesController < ApplicationController
  skip_before_action :require_login, only: [:index]
  
  include AddImageable
  
  def index
    recipes = Recipe.all
    if recipes
      render json: recipes
    else
      render json: {error: "no recipes available"}
    end
  end

  def create
    recipeObj = ActiveSupport::JSON.decode(params[:recipe])
    recipe = Recipe.create(
      name: recipeObj["name"],
      duration: recipeObj["duration"].to_i,
      cuisines: recipeObj["cuisines"],
      description: recipeObj["description"],
      ingredients: recipeObj["ingredients"],
      instructions: recipeObj["instructions"],
      user_id: recipeObj["user_id"]
    )

    if recipe.valid?
      if params[:items]
        create_items(recipe, params[:items])
      else
        render json: recipe, status: :created
      end
    else
      render json: {error: recipe.errors.full_messages}, status: :bad_request
    end
  end

  def update
    # byebug
    recipe = Recipe.find(params[:id])
    recipe.update(
      name: params[:name],
      duration: params[:duration],
      cuisines: params[:cuisines],
      description: params[:description],
      ingredients: params[:ingredients],
      instructions: params[:instructions],
      user_id: params[:user_id]
    )
    # recipes = Recipe.all
    if recipe.valid?
      render json: recipe, status: :created
    else
      render json: {error: recipe.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe_id = recipe.id
    recipe.destroy
    # byebug
    render json: recipe
  end
end
