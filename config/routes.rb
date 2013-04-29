Rpz::Application.routes.draw do
  resources :years do
    resources :faculties, :only => [:show] do
      resources :courses, :only => [:show] do
        resources :groups, except: [:destroy] do
          get '/:archived' => 'groups#index', :constraints => { :archived => /archived/ }, :as => :archived, :on => :collection, :defaults => { :archived => 'archived' }
          get '/change_archived_state' => 'groups#change_archived_state', :as => :change_archived_state, :on => :member
          get '/change_verified_state' => 'groups#change_verified_state', :as => :change_verified_state, :on => :member
        end
      end

      resources :streams, only: :index
    end
  end

  resources :users, :only => :index do
    resources :permissions, :only => [:new, :create, :destroy]
  end

  root :to => 'welcome#index'
end
