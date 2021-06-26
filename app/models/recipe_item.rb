# frozen_string_literal: true

class RecipeItem < ApplicationRecord
  class << self
    @@contentful_client = ContentfulClient.instance.client

    def get_recipe(recipe_id)
      contentful_recipe = @@contentful_client.entry(recipe_id)
      raise ArgumentError unless contentful_recipe

      {
        title: get_title(contentful_recipe),
        image_url: get_image_url(contentful_recipe),
        description: get_description(contentful_recipe),
        chef_name: get_chef_name(contentful_recipe),
        tags: get_tags(contentful_recipe)
      }
    end

    def fetch_recipes(skip = DEFAULT_SKIP, limit = DEFAULT_LIMIT)
      @@contentful_client.entries(
        content_type: RECIPE_CONTENT_TYPE,
        skip: skip,
        limit: limit
      ).map do |recipe|
        {
          id: recipe.id,
          title: recipe.title,
          image_url: recipe.photo.url
        }
      end
    end

    private

    def get_field_value(recipe, field)
      field = field.to_sym
      begin
        recipe.fields[field]
      rescue StandardError
        nil
      end
    end

    def get_title(contentful_recipe)
      get_field_value(contentful_recipe, 'title')
    end

    def get_description(contentful_recipe)
      get_field_value(contentful_recipe, 'description')
    end

    def get_image_url(contentful_recipe)
      photo = get_field_value(contentful_recipe, 'photo')
      begin
        photo.url
      rescue StandardError
        nil
      end
    end

    def get_chef_name(contentful_recipe)
      chef = get_field_value(contentful_recipe, 'chef')
      begin
        chef.name
      rescue StandardError
        nil
      end
    end

    def get_tags(contentful_recipe)
      tags = get_field_value(contentful_recipe, 'tags')
      begin
        tags.map(&:name).join(', ')
      rescue StandardError
        nil
      end
    end
  end
end
