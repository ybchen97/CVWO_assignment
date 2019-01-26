Rails.application.routes.draw do
  resources :todo_items do
    member do
      patch 'complete'
      patch 'uncomplete'
    end
    collection do
      delete 'destroy_completed'
    end
  end

  get 'tags/:tag', to: 'todo_items#index', as: 'tag'

  root 'todo_items#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
