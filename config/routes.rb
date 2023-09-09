Rails.application.routes.draw do
  namespace :admin do
    get 'messages/index'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  # 会員側
  scope module: :public do
    root to: "homes#top"
    get "users/mypage" => "users#show", as: 'mypage'
    get 'users/mypage/edit' => 'users#edit', as: 'edit_mypage'
    patch 'users/mypage' => 'users#update', as: 'update_mypage'
    get "posts_search" => "searches#posts_search"
    resources :users, only: [:show, :edit, :update]
    resources :posts do
      resources :comments, only: [:create, :destroy]
      resource :flowers, only: [:create, :destroy]
    end
  end

# 管理者側
# URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  #管理者側
  namespace :admin do
    # root to: "reports#index"
    resources :posts, only: [:destroy]
    resources :users, only: [:index, :show, :edit, :update]
    resources :messages, only: [:index, :create, :edit, :update]
    resources :reports, only: [:index, :edit, :update, :destroy]
  end

end
