Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :posts
  namespace :admin do
    resources :products
    resources :brands
    resources :dashboard, only: [ :index ]
  end

  devise_scope :user do
    authenticated do
      constraints(RoleConstraint.new.is_admin?) do
        root to: "admin/dashboard#index", as: :admin_root
        get '/admin/profile', to: "admin/dashboard#profile"
      end
    end
    authenticated do
      constraints(RoleConstraint.new.is_user?) do
        root to: "posts#index", as: :user_root
      end
    end
    unauthenticated do
      root to: "devise/sessions#new"
    end
  end  
end
