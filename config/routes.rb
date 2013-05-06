Rpz::Application.routes.draw do
  resources :years do
    resources :faculties, :only => [:show] do
      resources :courses, :only => [:show] do
        resources :streams do
          get '/:by_semester_title' => 'streams#index', :on => :collection, :constraints => { :by_semester_title => /autumn|spring/ }, :as => :semester, :defaults => { :by_semester_title => 'autumn' }
        end

        resources :groups, except: [:destroy] do
          get '/:archived' => 'groups#index', :constraints => { :archived => /archived/ }, :as => :archived, :on => :collection, :defaults => { :archived => 'archived' }
          get '/change_archived_state' => 'groups#change_archived_state', :as => :change_archived_state, :on => :member
          get '/change_verified_state' => 'groups#change_verified_state', :as => :change_verified_state, :on => :member
          resources :semesters, only: [:edit, :update]
        end
      end
    end
  end

  resources :users, :only => :index do
    resources :permissions, :only => [:new, :create, :destroy]
  end

  root :to => 'welcome#index'
end
