Rails.application.routes.draw do
  resources :todo_items do
  	member do
  		post 'complete'
  		post 'uncomplete'
  	end
  end

  root 'todo_items#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
