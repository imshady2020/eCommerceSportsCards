Rails.application.routes.draw do
  # get 'orders/index'
  # get 'orders/show'
  devise_for :customers
  root to: 'posts#index'
  # get 'posts/show'

  resources "posts", only: %i[index show]
  resources "cards", only: %i[index show]
  resources "orders", only: %i[index show]

  get 'new_cards', to: 'cards#new_cards', as: "new_cards"
  get 'updated_cards', to: 'cards#updated_cards', as: "updated_cards"

  get 'checkout', to: 'cards#checkout', as: 'checkout'
  get 'checkout/place_order', to: 'cards#place_order', as: 'place_order'

  post 'cards/add_to_cart/:id', to: 'cards#add_to_cart', as: "add_to_cart"
  post 'cards/edit_cart_item/:id', to: 'cards#edit_cart_item', as: "edit_cart_item"
  delete 'cards/remove_from_cart/:id', to: 'cards#remove_from_cart', as: "remove_from_cart"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
