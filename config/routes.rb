Rails.application.routes.draw do
  get 'schedules/index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers=>{:sessions=>"session"}

  root 'welcome#index'
  resources :equipments, :lessons
  get 'schedule',:to=>'schedules#index', :as=>:create_schedule
  post 'schedule/create',:to=>'schedules#arrange_schedule', :as=>:arrange_schedule
end
