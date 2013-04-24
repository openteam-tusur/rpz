Rpz::Application.routes.draw do
  resources :years
  root :to => 'years#index'
end
