Rails.application.routes.draw do
  root to: 'homes#top'
  get 'homes/company_info' => 'company_info'
  get 'homes/influencer_info' => 'influencer_info'
  
  devise_scope :influencer do
    post 'influencers/guest_sign_in', to: 'influencers/sessions#new_guest'
  end
  devise_scope :company do
    post 'companies/guest_sign_in', to: 'companies/sessions#new_guest'
  end

  devise_for :influencers, controllers: {
    sessions:      'influencers/sessions',
    passwords:     'influencers/passwords',
    registrations: 'influencers/registrations'
  }
  devise_for :companies, controllers: {
    sessions:      'companies/sessions',
    passwords:     'companies/passwords',
    registrations: 'companies/registrations'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects, only: [:new, :create, :index, :show, :destroy] do
    member do
      patch "influencers/:influencer_id"=> 'influencer_projects#completion',as: :completion
      get "influencers/:influencer_id/reviews/new"=> 'reviews#new',as: :review_new
      post "influencers/:influencer_id/reviews"=> 'reviews#create',as: :review_post
    end
    resources :influencer_projects, only: [:destroy]
     member do
      post 'favorites' => 'favorites#create'
      delete 'favorites' => 'favorites#destroy'
    end
  end

  resources :influencer_projects, only: [:new,:create,:show,:update,:index] do
    member do
      resources :company_reviews, only: [:new,:create]
    end
  end



  resources :notifications, only: [:index]

  resources :companies, only: [:show, :edit, :update, :destroy , :index]
  resources :influencers, only: [:create,:edit, :index, :show, :destroy, :update]

  get 'searchs/search', to: 'searchs#search'

end
