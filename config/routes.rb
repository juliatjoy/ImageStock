Rails.application.routes.draw do
  constraints format: :json do
    resources :images,  only: %i[create show]
  end
end
