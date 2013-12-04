Spree::Core::Engine.routes.append do
  get '/currency/set', to: 'currency#set', defaults: { format: :json }, as: :set_currency

  namespace :admin do
    resources :products do
      resources :prices, only: [:index, :create]
      resources :currencies
      resources :currency_converters
    end
  end
end
