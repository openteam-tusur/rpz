Rpz::Application.routes.draw do
  resources :years do
    resources :faculties, :only => [:show] do
      resources :courses, :only => [:show] do
        resources :streams, :except => [:show] do
          get '/:by_semester_title' => 'streams#index', :on => :collection, :constraints => { :by_semester_title => /autumn|spring/ }, :as => :semester, :defaults => { :by_semester_title => 'autumn' }
          get '/search' => 'streams#search', :on => :collection, :as => :search
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

  resources :trainings, :only => [] do
    get '/change_monitored_state' => 'trainings#change_monitored_state', :as => :change_monitored_state, :on => :member
  end

  resources :educations, :only => [] do
    get '/change_gpo_alternative_state' => 'educations#change_gpo_alternative_state', :as => :change_gpo_alternative_state, :on => :member
    get '/change_active_state'          => 'educations#change_active_state',          :as => :change_active_state,          :on => :member
  end

  root :to => 'welcome#index'
end
