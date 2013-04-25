Rpz::Application.routes.draw do
  namespace :manage do
    resources :users, :only => :index do
      resources :permissions, :only => [:new, :create, :destroy]
    end
    root :to => 'users#index'
  end

  resources :years do
    resources :faculties, :only => [:show] do
      get '/groups/(:by_course)' => 'groups#index', :constraints => { :by_course => /course_\d+/ }, :as => :scoped_groups
      resources :groups, :only => [:show, :new, :create, :edit, :update]
    end
  end

  root :to => 'years#index'
end
