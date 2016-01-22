Elasticsearcher::Application.routes.draw do

  resources :authors do
    collection do
      match '/search/:query' => 'authors#search', via: [:get]
      match '/search' => 'authors#search', via: [:post]
    end
  end
  resources :posts do
    collection do
      match '/search/:query' => 'posts#search', via: [:get]
      match '/search' => 'posts#search', via: [:post]
    end
  end
  namespace :api do
    match "/reindex" => 'search#reindex', via: [:get]
  end

  match '/search/:query' => 'search#search', via: [:get], as: :search
  match '/search' => 'search#search', via: [:post]

  root to: 'pages#root'

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

end
