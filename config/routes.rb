Elasticsearcher::Application.routes.draw do

  resources :authors
  resources :posts
  root to: 'pages#root'

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

end
