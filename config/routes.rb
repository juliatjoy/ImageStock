Rails.application.routes.draw do
  constraints format: :json do
    resources :images
  end
end
