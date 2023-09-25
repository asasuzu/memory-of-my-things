class Admin::MessagesController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_message, only: [:show, :edit, :update, :destroy]

  def index
    @message = Message.new
    @messages = Message.all.order(created_at: :desc)
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to admin_messages_path
    else
      @messages = Message.all.order(created_at: :desc)
      flash.now[:alert] = "登録に失敗しました"
      render :index
    end
  end

  def edit
  end

  def update
    if @message.update(message_params)
      redirect_to admin_messages_path
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit
    end
  end

  def destroy
    if @message.destroy
      redirect_to admin_messages_path, notice: "遺言が削除されました"
    else
      flash.now[:alert] = "遺言の削除に失敗しました"
      render :edit
    end
  end

  private

  def message_params
    params.require(:message).permit(:message)
  end

  def ensure_message
    @message = Message.find_by_id(params[:id])
    unless @message
      redirect_to admin_messages_path
    end
  end

end