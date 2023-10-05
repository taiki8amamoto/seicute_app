# frozen_string_literal: true

Rails.application.routes.draw do
  root 'invoices#index'
  resources :invoices, only: %w(new create index show)
  resources :requestors, only: %w(create)
end
