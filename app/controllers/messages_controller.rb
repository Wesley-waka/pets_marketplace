class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show update destroy ]

  def create
    message = current_user.messages.build(message_params)
    if message.save
      ActionCable.server.broadcast "chatroom_channel", mode_message: message_render(message)
    end 
  end


  private

  def message_params
    params.require(:message).permit(:body)
  end

  def message_render(message)
    render(partial: 'message', locals: {message: message})
  end


end
