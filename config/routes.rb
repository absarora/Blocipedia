Blocipedia::Application.routes.draw do

  get "collaborations/create"

  devise_for :users, :controllers => {:registrations => "users/registrations"}

  resources :charges

# /wikis/23/collaborations
# params :wiki_id

  resources :wikis do
    #resources :pages, except: [:index]
    resources :collaborations, only: [:new, :create]
  end

  match "about" => 'welcome#about', via: :get

  root :to => 'welcome#index'
end
