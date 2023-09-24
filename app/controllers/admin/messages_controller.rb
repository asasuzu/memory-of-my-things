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
      render :index
    end
  end

  def edit
  end

  def update
    if @message.update(message_params)
      redirect_to admin_messages_path
    else
      render :edit
    end
  end

  def destroy
    @message.destroy
    redirect_to admin_messages_path, notice: "遺言が削除されました"
  end

  private

  def message_params
    params.require(:message).permit(:message)
  end

  def ensure_message
    @message = Message.find(params[:id])
  end
end