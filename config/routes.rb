# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'sessions/new'
  # get 'sessions/create'
  # get 'sessions/destroy'
  # get 'requestors/index'
  # get 'requestors/new'
  root 'invoices#index'
  resources :invoices, only: %w(new create index show)
  resources :requestors, only: %w(new create index)
  resources :users, only: %w(new create)
  resources :sessions, only: %w(new create destroy)

end
