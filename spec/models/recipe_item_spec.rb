# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeItem, type: :model do
  describe '#get_recipe' do
    it 'gets recipe from contentful' do
      described_class.class_variable_set :@@contentful_client, instance_double('client')
      allow(described_class.class_variable_get(:@@contentful_client)).to receive(:entry).and_return({ k: 'v' })
      allow(described_class).to receive(:get_title).and_return('Title')
      allow(described_class).to receive(:get_description).and_return('Description')
      allow(described_class).to receive(:get_image_url).and_return('//image')
      allow(described_class).to receive(:get_chef_name).and_return('Chef name')
      allow(described_class).to receive(:get_tags).and_return('tag1, tag2')
      recipe_obj = {
        title: 'Title',
        image_url: '//image',
        description: 'Description',
        chef_name: 'Chef name',
        tags: 'tag1, tag2'
      }
      expect(described_class.get_recipe('valid_id')).to eq(recipe_obj)
    end

    it 'raises Argument error if invalid recipe id' do
      described_class.class_variable_set :@@contentful_client, instance_double('client')
      allow(described_class.class_variable_get(:@@contentful_client)).to receive(:entry).and_return(nil)
      expect { described_class.get_recipe('random_id') }.to raise_error(ArgumentError)
    end
  end

  describe '#fetch_recipes' do
    let!(:photo_obj) { instance_double('photo', url: '//img1') }
    let!(:recipe_obj) do
      instance_double('recipe', id: 'id1', title: 't1', photo: photo_obj)
    end

    it 'gets list of recipes from contentful' do
      list_recipes_contentful = [recipe_obj]
      list_recipes = [{ id: recipe_obj.id, title: recipe_obj.title,
                        image_url: recipe_obj.photo.url }]
      described_class.class_variable_set :@@contentful_client, instance_double('client')
      allow(described_class.class_variable_get(:@@contentful_client)).to receive(:entries).and_return(list_recipes_contentful)
      expect(described_class.fetch_recipes).to eq(list_recipes)
    end
  end

  describe '#get_field_values' do
    let!(:photo_obj) { instance_double('photo', url: '//image') }
    let!(:chef_obj) { instance_double('chef', name: 'Chef name') }
    let(:tag_obj1) { instance_double('tag', name: 'tag1') }
    let(:tag_obj2) { instance_double('tag', name: 'tag2') }
    let(:recipe) do
      {
        title: 'Title',
        description: 'Description',
        photo: photo_obj,
        chef: chef_obj,
        tags: [tag_obj1, tag_obj2]
      }
    end
    let(:recipe_obj) { instance_double('recipe', fields: { title: 'Title' }) }

    it '#get_title' do
      allow(described_class).to receive(:get_field_value).and_return(recipe[:title])
      expect(described_class.send(:get_title, recipe)).to eq('Title')
    end

    it '#get_description' do
      allow(described_class).to receive(:get_field_value).and_return(recipe[:description])
      expect(described_class.send(:get_description, recipe)).to eq('Description')
    end

    it '#get_image_url' do
      allow(described_class).to receive(:get_field_value).and_return(recipe[:photo])
      expect(described_class.send(:get_image_url, recipe)).to eq('//image')
    end

    it '#get_chef_name' do
      allow(described_class).to receive(:get_field_value).and_return(recipe[:chef])
      expect(described_class.send(:get_chef_name, recipe)).to eq('Chef name')
    end

    it '#get_chef_name nil if chef does not exist' do
      allow(described_class).to receive(:get_field_value).and_return(nil)
      expect(described_class.send(:get_chef_name, recipe)).to eq(nil)
    end

    it '#get_tags' do
      allow(described_class).to receive(:get_field_value).and_return(recipe[:tags])
      expect(described_class.send(:get_tags, recipe)).to eq('tag1, tag2')
    end

    it '#get_tags nil if tags does not exist' do
      allow(described_class).to receive(:get_field_value).and_return(nil)
      expect(described_class.send(:get_tags, recipe)).to eq(nil)
    end

    it '#get_field_value success' do
      expect(described_class.send(:get_field_value, recipe_obj, 'title')).to eq('Title')
    end

    it '#get_field_value nil' do
      expect(described_class.send(:get_field_value, recipe, 'unknown_key')).to eq(nil)
    end
  end
end
