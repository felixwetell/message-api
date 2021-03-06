Rails.application.routes.draw do
  post 'login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  namespace 'api' do
    namespace 'v1' do
      resources :messages
    end
  end
end
