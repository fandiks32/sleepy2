Rails.application.routes.draw do
  resources :users do
    post :clock_out, to: 'clock_in_outs#clock_out'
    post :clock_in, to: 'clock_in_outs#clock_in'

    get :clocks, to: 'clock_in_outs#index'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
