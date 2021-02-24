Rails.application.routes.draw do
  root to: 'homes#top'
  get 'homes/company_info' => 'company_info'
  get 'homes/influencer_info' => 'influencer_info'

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
      # patch "influencers/:influencer_id"=> 'influencer_projects#evaluation',as: :evaluation
    end
    resources :influencer_projects, only: [:destroy]
     member do
      post 'favorites' => 'favorites#create'
      delete 'favorites' => 'favorites#destroy'
    end
  end
  # get 'influencer_projects/new' => 'influencer_projects#new'
  # post 'influencer_projects/' => 'influencer_projects#create'
  # get 'influencer_projects/show' => 'influencer_projects#show'
  resources :influencer_projects, only: [:new,:create,:show,:update,:index]

  resources :notifications, only: [:index]

  resources :companies, only: [:show, :edit, :update, :destroy , :index]
  resources :influencers, only: [:create,:edit, :index, :show, :destroy, :update]

  get 'searchs/search', to: 'searchs#search'

end
