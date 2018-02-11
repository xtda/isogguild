Rails.application.routes.draw do
  require 'sidekiq/web'

  root 'home#index'

  get '/apply', to: 'playerapp#new'
  post 'apply', to: 'playerapp#create', as: 'playerapps'

  get '/app/:id', to: 'playerapp#show', as: 'playerapp'
  get '/applied', to: 'applied#index'

  
  get '/user/edit', to: 'user#edit', as: 'user_edit'
  patch '/user', to: 'user#update', as: 'user'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/signin" => "clearance/sessions#new", as: "sign_in"
  delete "/signout" => "clearance/sessions#destroy", as: "sign_out"
  get "/signup" => "clearance/users#new", as: "sign_up"


  constraints Clearance::Constraints::SignedIn.new { |user| user.admin? } do
    mount Sidekiq::Web, at: '/sidekiq'
  end

  namespace :admin do
    get 'test', to: 'admintest#index'
    get 'frontpage', to: 'frontpage#edit', as: 'frontpage'
    post 'frontpage', to: 'frontpage#update', as: 'frontpage_edit'
  end

  scope module: 'api' do
    namespace :v1 do
      namespace :wow do
        get '/realms', to: 'realms#index'
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
