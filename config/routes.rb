Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: {
  registrations: 'public/registrations',
  sessions: 'public/sessions'
  }

  devise_scope :user do
    post 'guest_sign_in', to: 'public/sessions#guest_sign_in'
    delete 'guest_sign_out', to: 'public/sessions#guest_sign_out'
  end

  # ユーザー側
  scope module: :public do
    root to: "homes#top"
    get 'search' => 'posts#search', as: 'search_posts'
    get 'users/mypage' => 'users#mypage', as: 'mypage'
    get 'users/mypage/edit' => 'users#edit', as: 'edit_mypage'
    patch 'users/mypage' => 'users#update', as: 'update_mypage'
    get 'users/mypage/flowering' => 'users#flowering', as: 'mypage_flowering'
    resources :users, only: [:show]
    resources :posts do
      get 'goodbye', on: :member
      resources :comments, only: [:create, :destroy] do
        resources :reports, only: [:new, :create]
      end
      resource :flowers, only: [:create, :destroy]
      resources :reports, only: [:new, :create]
    end
  end

# 管理者側
# URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: 'admin/sessions'
  }

  #管理者側
  namespace :admin do
    resources :users, only: [:index, :show, :update]
    resources :posts, only: [:destroy]
    resources :messages, only: [:index, :create, :edit, :update, :destroy]
    resources :reports, only: [:index, :show, :update, :destroy] do
      collection do
        delete 'destroy_selected', to: 'reports#destroy_selected'
      end
    end
  end

end
