class MessagesController < ApplicationController
  before_action :set_conversation
  before_action :set_prompt

  def create
    @new_message = Message.new
    @message = @conversation.messages.build(message_params)
    @message.creating_entity = "user"
    
    is_saved = @message.save
    render turbo_stream: [
      turbo_stream.replace('message_form', partial: "messages/message_form", locals: { message: @new_message }),
      # turbo_stream.replace('message_errors', partial: "message_errors", locals: { message: @message })
    ]

    if is_saved
      # Prompt conversation model for response?
      @conversation.create_responses
    end

  end

  private
    def set_conversation
      @conversation = Conversation.visible_by_user(current_or_guest_user).find(params[:conversation_id])
    end 

    def set_prompt
      @prompt = @conversation.prompt
    end 

    def message_params
      params.require(:message).permit(:body, :conversation_id)
    end
end

