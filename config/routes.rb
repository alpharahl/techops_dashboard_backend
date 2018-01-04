Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :api

  get 'index' => 'api#index'
  get 'mark_shift_worked' => 'api#mark_shift_worked'
  get 'current_shifts' => 'api#current_shifts'
  get 'check_auth' => 'api#check_auth'
end
