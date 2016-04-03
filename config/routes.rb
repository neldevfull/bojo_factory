Rails.application.routes.draw do

    resources :orders, only: [:new, :create, :sendproduction]
        get "orders" => "orders#new",
            as: :new_orders
        post "sendproduction" => "orders#sendproduction",
            as: :send_production
end
