Rails.application.routes.draw do

  root 'home#index'

  devise_for :users, :path_names => {:sign_in => 'login', :sign_out => 'logout'}, :controllers => { :registrations => "users/registrations", :sessions => "users/sessions" }

  resources :users, only: [:show] do
    collection do
      get :welcome
      get :favorite_places
      get :taken_promos
    end
  end

  #landing
  get 'landing' => 'home#landing'
  get 'business' => 'home#business'
  get 'terms' => 'home#terms'
  get 'about_us' => 'home#about_us'
  get 'legal' => 'home#legal'
  get 'contact_us' => 'home#contact_us'
  get 'faq' => 'home#faq'
  get 'pricing' => 'home#pricing'
  get 'bring_rewardners_to_your_city' => 'home#bring_rewardners_to_your_city'
  get 'join_rewardners' => 'home#join_rewardners'
  get 'local_projects' => 'home#local_projects'
  get 'rewardners_international' => 'home#rewardners_international'

  # Promos
  resources :promos, only: [:index] do
    collection do
      get :trendings
      get :search
      get :public_search
    end
  end

  # Payments
  # resources :payments, only: [:index, :show, :new, :create] do
  #   collection do
  #     get "approve/confirmed" => 'payments#confirmation_status', as: :approve_confirmed
  #     get "approve/denied" => 'payments#confirmation_status', as: :approve_denied
  #   end
  # end

  # Places
  resources :places do
    member do
      post :like
      delete :unlike
      get :info
    end
    collection do
      get :stars
      get :discover
    end
    resources :promos do
      member do
        post :take
        delete :untake
      end
    end
  end

  resources :taken_promos, only: [:index] do
    member do
      post :accept
      delete :reject
    end
  end

  resources :redeems, only: [:index, :new, :create, :destroy] do
    collection do
      get :delivery
      get ":place_id/:user_id" => 'redeems#new', as: :for_user_in_place
      get :processed
    end
  end

  resources :contacts, only:[:new, :create]

  resources :subscriptions do
    member do
      get :make_recurring
    end
  end

  post 'paypal/ipn_listener' => 'paypal#ipn_listener'

  resources :activities, only: [:index] do
    collection do
      get :tiny_index
    end
  end

  # Administrador
  resources :categories do
    collection do
      get :subcategories
    end
  end

  # API
  mount Rewardners::Root => '/'

end
