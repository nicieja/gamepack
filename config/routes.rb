# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  # root "articles#index"

  resources :conversations, only: %i[create show] do
    resources :messages, only: %i[create]
  end

  mount Sidekiq::Web => '/sidekiq'
end
