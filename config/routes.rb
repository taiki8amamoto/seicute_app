# frozen_string_literal: true

Rails.application.routes.draw do
  get 'searches/search'
  root 'invoices#index'
  resources :invoices, only: %w(new create index show)
  resources :requestors, only: %w(new create index)
  resources :sessions, only: %w(new create destroy)
  resources :users, only: %w(new create index edit update destroy)
end
