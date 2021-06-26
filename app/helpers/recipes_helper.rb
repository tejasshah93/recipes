# frozen_string_literal: true

module RecipesHelper
  def validate_pagination_params(skip, limit)
    valid = true
    valid &&= valid_skip(skip) if skip
    valid &&= valid_limit(limit) if limit
    valid
  end

  def valid_skip(skip)
    skip.to_i >= 0
  end

  def valid_limit(limit)
    limit.to_i >= 1 && limit.to_i <= 100
  end
end
