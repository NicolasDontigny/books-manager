Rails.application.routes.draw do
  devise_for :users
  root 'books#index'

  get 'books' => 'books#index', as: :books
  get 'books/new' => 'books#new', as: :new_book
  get 'books/:id' => 'books#show', as: :book
  post 'books' => 'books#create'
  post 'books/website' =>
    'books#create_from_website', as: :create_book_from_website
  get 'books/:id/edit' => 'books#edit', as: :edit_book
  patch 'books/:id' => 'books#update'
  delete 'books/:id' => 'books#destroy'

  get 'reading-list' => 'reading_list_items#index', as: :reading_list
  get 'reading-list/read' => 'reading_list_items#read_books', as: :read_books
  post 'reading-list/book/:book_id' =>
    'reading_list_items#create', as: :reading_list_item
  patch 'reading-list/book/:book_id' =>
    'reading_list_items#update'
  post 'reading-list/book/:book_id/mark-as-read' =>
    'reading_list_items#mark_as_read', as: :mark_as_read
  post 'reading-list/book/:book_id/mark-as-unread' =>
    'reading_list_items#mark_as_unread', as: :mark_as_unread
  delete 'reading-list/book/:book_id' => 'reading_list_items#destroy'
end
