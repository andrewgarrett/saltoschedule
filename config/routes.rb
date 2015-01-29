Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers=>{:sessions=>"session"}

  root 'welcome#index'
  resources :equipments, :lessons
end
