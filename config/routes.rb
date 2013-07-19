Spree::Core::Engine.routes.append do
  match '/currency/set', to: 'currency#set', defaults: { format: :json }, as: :set_currency

  namespace :admin do
    resources :products do
      resources :prices, only: [:index, :create]
    end
  end
end
