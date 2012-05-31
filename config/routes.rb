PageDemo::Application.routes.draw do
  namespace :api do
    resources :pages do
      get :published, on: :collection
      get :unpublished, on: :collection
      post :publish, on: :member
      get :total_words, on: :member
    end
  end
end
