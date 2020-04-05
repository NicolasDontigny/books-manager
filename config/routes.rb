Rails.application.routes.draw do
  devise_for :users
  root 'books#index'

  get 'books' => 'books#index', as: :books
  get 'books/new' => 'books#new', as: :new_book
  get 'books/:id' => 'books#show', as: :book
  post 'books' => 'books#create'
  get 'books/:id/edit' => 'books#edit', as: :edit_book
  patch 'books/:id' => 'books#update'
  delete 'books/:id' => 'books#destroy'

  get 'reading-list' => 'reading_list_items#index', as: :reading_list
  post 'reading-list/book/:book_id' => 'reading_list_items#create', as: :reading_list_item
  delete 'reading-list/book/:book_id' => 'reading_list_items#destroy'
end
