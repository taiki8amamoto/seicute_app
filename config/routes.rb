# frozen_string_literal: true

Rails.application.routes.draw do
  get 'requestors/index'
  get 'requestors/new'
  root 'invoices#index'
  resources :invoices, only: %w(new create index show)
  resources :requestors, only: %w(new create index)
end
