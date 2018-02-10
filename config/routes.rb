Rails.application.routes.draw do

  require 'sidekiq/web'
  root 'home#index'

  get '/apply', to: 'playerapp#new'
  post 'apply', to: 'playerapp#create', as: 'playerapps'

  get '/app/:id', to: 'playerapp#show', as: 'playerapp'
  get '/applied', to: 'applied#index'

  mount Sidekiq::Web, at: '/sidekiq'

  scope module: 'api' do
    namespace :v1 do
      namespace :wow do
        get '/realms', to: 'realms#index'
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
