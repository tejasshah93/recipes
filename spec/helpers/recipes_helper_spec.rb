# frozen_string_literal: true

require 'rails_helper'
include RecipesHelper

RSpec.describe RecipesHelper do
  describe '#valid_skip' do
    it 'returns true for valid skip value' do
      expect(valid_skip(0)).to eq(true)
    end

    it 'returns false for invalid skip value' do
      expect(valid_skip(-1)).to eq(false)
    end
  end

  describe '#valid_limit' do
    it 'returns true for valid limit value' do
      expect(valid_skip(1)).to eq(true)
    end

    it 'returns false for invalid limit value' do
      expect(valid_skip(-1)).to eq(false)
    end
  end

  describe '#validate_pagination_params' do
    it 'returns true for valid skip and limit value' do
      expect(validate_pagination_params(1, 1)).to eq(true)
    end

    it 'returns false for invalid skip/limit value' do
      expect(validate_pagination_params(-1, -1)).to eq(false)
    end
  end
end
