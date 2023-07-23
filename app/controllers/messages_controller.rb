class MessagesController < ApplicationController
  before_action :set_conversation
  def create
    @message = @conversation.messages.build(conversation_params)
    @message.user = @current_user

    
      

  end

  def delete
  end

  private
    def set_conversation
      @conversation = Conversation.visible_to_user.find(params[:conversation_id])
    end 

    def message_params
      params.require(:message).permit(:body, :conversation_id)
    end
end
