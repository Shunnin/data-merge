Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope 'api', defaults: { format: :json } do
    resources :hotels, only: [:index]
  end

  require 'sidekiq/web'
  require 'sidekiq/cron/web'

  Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
    [user, password] == [Settings.sidekiq.username, Settings.sidekiq.pass]
  end
  Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]

  mount Sidekiq::Web => '/sidekiq'
end
