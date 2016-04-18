Elasticsearchr::Application.routes.draw do

  resources :authors do
    collection do
      match '/search' => 'authors#search', via: [:post]
      match '/search/:query' => 'authors#search', via: [:get]
    end
  end
  resources :posts do
    collection do
      match '/search' => 'posts#search', via: [:post]
      match '/search/:query' => 'posts#search', via: [:get]
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
