class ConversationsController < ApplicationController
  before_action :set_prompt
  before_action :set_conversation, only: %i[show destroy]

  # GET /conversations/1 or /conversations/1.json
  def show
    @messages = @conversation.messages
    @new_message = Message.new
  end

  # GET /conversations/new
  def new
    @conversation = Conversation.new
  end

  # POST /conversations or /conversations.json
  def create
    @conversation = @prompt.conversations.build(conversation_params)
    @conversation.user = @current_user

    if @conversation.save
      redirect_to prompt_conversation_url(@prompt, @conversation), notice: "Conversation was successfully created."
    else
      render :new, status: :unprocessable_entity 
    end 
  end

  # DELETE /conversations/1 or /conversations/1.json
  def destroy
    @conversation.destroy
    redirect_to prompts_url, notice: "Conversation ended."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.visible_to_user(@current_user).find(params[:id])
    end

    def set_prompt
      @prompt = Prompt.visible_to_user(@current_user).find(params[:prompt_id])
    end 

    # Only allow a list of trusted parameters through.
    def conversation_params
      params.require(:conversation).permit(:training_language, :native_language, :prompt_id)
    end
end
