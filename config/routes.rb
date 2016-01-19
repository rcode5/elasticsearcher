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
  root to: 'pages#root'

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

end
