Rails.application.routes.draw do
  get 'home/index'
  root "home#index"
  get 'home/makerequest', to: "home#makerequest", as: 'makerequest'
end
