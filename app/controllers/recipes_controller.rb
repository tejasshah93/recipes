# frozen_string_literal: true

class RecipesController < ApplicationController
  include RecipesHelper

  def index
    skip = params[:skip] || DEFAULT_SKIP
    limit = params[:limit] || DEFAULT_LIMIT
    raise RangeError unless validate_pagination_params(skip, limit)

    @recipes = RecipeItem.fetch_recipes(skip, limit)
    respond_to do |format|
      format.html
      format.json { render json: @recipes }
    end
  rescue StandardError => e
    error_handler(e)
  end

  def show
    @recipe = RecipeItem.get_recipe(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @recipe }
    end
  rescue StandardError => e
    error_handler(e)
  end
end
