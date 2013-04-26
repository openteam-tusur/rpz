Rpz::Application.routes.draw do
  namespace :manage do
    resources :users, :only => :index do
      resources :permissions, :only => [:new, :create, :destroy]
    end
    root :to => 'users#index'
  end

  resources :years do
    resources :faculties, :only => [:show] do
      resources :groups, :only => [:show, :new, :create, :edit, :update] do
        get '/:by_course' => 'groups#index', :constraints => { :by_course => /course_\d+/ }, :as => :scoped, :on => :collection
        get '/:archived' => 'groups#index', :constraints => { :archived => /archived/ }, :as => :archived, :on => :collection, :defaults => { :archived => 'archived' }
        get '/change_archived_state' => 'groups#change_archived_state', :as => :change_archived_state, :on => :member
      end
    end
  end

  root :to => 'years#index'
end
