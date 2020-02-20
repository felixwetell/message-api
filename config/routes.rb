Rails.application.routes.draw do
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'api/v1/users#create'
  namespace 'api' do
    namespace 'v1' do
      resources :messages
    end
  end
end
