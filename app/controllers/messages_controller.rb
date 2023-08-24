class MessagesController < ApplicationController
  before_action :set_conversation
  def create
    @message = @conversation.messages.build(message_params)
    @message.creating_entity = "user"
    @message.user = current_or_guest_user
    
    is_saved = @message.save
    render turbo_stream: turbo_stream.replace('message_errors', partial: 'message_errors', locals: { message: @message })
    if is_saved
      # Prompt conversation model for response?
      @conversation.ai_respond
    end
  end

  private
    def set_conversation
      @conversation = Conversation.visible_by_user(current_or_guest_user).find(params[:conversation_id])
    end 

    def message_params
      params.require(:message).permit(:body, :conversation_id)
    end
end

