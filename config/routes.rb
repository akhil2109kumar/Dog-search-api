Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :dogs, only: %i[create] do
    # collection do
    #   post :show_by_breed
    # end
  end
end
