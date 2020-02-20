Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :messages
      resources :users, only: :create
      post 'auth/login', to: 'authentication#authenticate'
      post 'signup', to: 'users#create'
    end
  end
end
