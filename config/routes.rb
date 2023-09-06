Rails.application.routes.draw do
  namespace :public do
    get 'users/show'
    get 'users/edit'
  end
  namespace :public do
    get 'homes/top'
  end
  namespace :public do
    get 'posts/new'
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

# 管理者用
# URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  # 顧客用
  scope module: :public do
    root to: "homes#top"
    get "/mypage" => "users#show"
    get "mypage/edit" => "users#edit"
    patch "/mypage" => "users#update"
    get "posts_search" => "searches#posts_search"
    resources :posts do
      resources :comments, only: [:create, :destroy]
      resource :flowers, only: [:create, :destroy]
    end
  end
  
  #管理者用
  namespace :admin do
    root to: "homes#top"
    resources :posts, only: [:destroy]
    resources :users, only: [:index, :show, :edit, :update]
  end

end
