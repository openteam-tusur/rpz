Rpz::Application.routes.draw do
  resources :years do
    resources :faculties, :only => [:show] do
      resources :groups, :only => [:show, :new, :create, :edit, :update] do
        get '/:by_course' => 'groups#index', :constraints => { :by_course => /course_\d+/ }, :as => :scoped, :on => :collection
        get '/:archived' => 'groups#index', :constraints => { :archived => /archived/ }, :as => :archived, :on => :collection, :defaults => { :archived => 'archived' }
        get '/change_archived_state' => 'groups#change_archived_state', :as => :change_archived_state, :on => :member
        get '/change_verified_state' => 'groups#change_verified_state', :as => :change_verified_state, :on => :member
      end
    end
  end

  resources :users, :only => :index do
    resources :permissions, :only => [:new, :create, :destroy]
  end

  root :to => 'years#index'
end
