# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_inactive_user, only: [:create]
  
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  def guest_sign_in
    user = User.create_guest
    sign_in(user)
    redirect_to root_path,
    notice: 'ゲストユーザーとしてログインしました。投稿やコメントはログアウト後に削除されます。'
  end
  
    # ゲストユーザーのログアウト
  def guest_sign_out
    if current_user.guest?
      current_user.destroy  # ゲストユーザーを削除する
      sign_out(current_user)  # ログアウト
      redirect_to root_path, notice: 'ゲストユーザーアカウントが削除されました。'
    else
      redirect_to root_path
    end
  end
  
  def reject_inactive_user
    @user = User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && !@user.is_active
        flash[:danger] = 'こちらのアカウントは利用停止中です。'
        redirect_to new_user_session_path
      end
    end
  end
  
end
