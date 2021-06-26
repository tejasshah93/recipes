# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  context 'when GET /recipes' do
    it 'assigns @recipes' do
      list_recipes = [{ id: 'id1', title: 't1', image_url: '//img1' }]
      allow(RecipeItem).to receive(:fetch_recipes).and_return(list_recipes)
      get :index
      expect(assigns(:recipes)).to eq(list_recipes)
      expect(response).to have_http_status(:ok)
    end
  end

  context 'when GET /recipes/:id' do
    it 'assigns @recipe' do
      recipe_obj = {
        title: 'Title',
        image_url: '//image',
        description: 'Description',
        chef_name: 'Chef name',
        tags: 'tag1, tag2'
      }
      allow(RecipeItem).to receive(:get_recipe).and_return(recipe_obj)
      get :show, params: { id: 'valid_id' }
      expect(assigns(:recipe)).to eq(recipe_obj)
      expect(response).to have_http_status(:ok)
    end

    it 'returns error for invalid id' do
      allow(RecipeItem).to receive(:get_recipe).and_raise(ArgumentError)
      get :show, params: { id: 'invalid_id' }
      expect(response).to have_http_status(:not_found)
    end
  end
end
