# frozen_string_literal: true

Rails.application.routes.draw do
  root to: redirect(path: '/recipes')
  resources :recipes, only: %i[index show]
end
