Blocipedia::Application.routes.draw do

  devise_for :users

  resources :wikis do
    resources :pages, except: [:index]
  end

  match "about" => 'welcome#about', via: :get

  root :to => 'welcome#index'
end
