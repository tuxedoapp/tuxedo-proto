TuxedoProto::Application.routes.draw do


  #DEVISE
  # devise_for :vendors
  # devise_for :people
  devise_for :users, controllers: { :registrations => 'user_registrations' }

  #ROUTES
  root to: 'static_pages#home'
  match '/registration_choice', to: 'static_pages#registration_choice', via: 'get'
  match '/person_profile',    to: 'people#show',                   via: 'get'
  match '/vendor_profile',      to: 'vendors#show',                     via: 'get'
  match '/explore',             to: 'experiences#explore',               via: 'get'

  devise_scope :user do
    get 'vendor/sign_up' => 'user_registrations#new', :user => { :user_type => 'vendor' }
    get 'person/sign_up' => 'user_registrations#new', :user => { :user_type => 'person' }
  end

  # Routes for Yelp information
  resource :vendors do
    collection do
      get :confirm_details
      put :update_details
    end
  end

  resource :experiences do
    member do
      get :explore
    end
  end

  resource :people do
	 resource :adventures
  end

  resource :adventures do
    resource :journey_items do
      member do
        post :change
      end
    end
  end

  resource :vendors do
    resource :experiences
  end

  resource :experiences do
    resource :experience_times
  end
end
