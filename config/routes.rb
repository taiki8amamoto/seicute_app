# frozen_string_literal: true

Rails.application.routes.draw do
  get 'invoices/index'
  get 'invoices/new'
  get 'invoices/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
