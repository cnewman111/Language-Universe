class MessagesController < ApplicationController
  before_action :set_conversation
  def create
    @message = @conversation.messages.build(message_params)
    @message.user = @current_user

    @message.save
  end

  def delete
  end

  private
    def set_conversation
      @conversation = Conversation.visible_to_user(@current_user).find(params[:conversation_id])
    end 

    def message_params
      params.require(:message).permit(:body, :conversation_id)
    end
end
