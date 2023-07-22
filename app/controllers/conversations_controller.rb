class ConversationsController < ApplicationController
  before_action :set_prompt
  before_action :set_conversation, only: %i[show destroy]

  # GET /conversations/1 or /conversations/1.json
  def show
  end

  # GET /conversations/new
  def new
    @conversation = Conversation.new
  end

  # POST /conversations or /conversations.json
  def create
    @conversation = @prompt.conversations.build(conversation_params)
    @conversation.user = @current_user

    respond_to do |format|
      if @conversation.save
        format.html { redirect_to prompt_conversation_url(@prompt, @conversation), notice: "Conversation was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1 or /conversations/1.json
  def destroy
    @conversation.destroy

    respond_to do |format|
      format.html { redirect_to prompts_url, notice: "Conversation ended." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    def set_prompt
      @prompt = Prompt.find(params[:prompt_id])
    end 

    # Only allow a list of trusted parameters through.
    def conversation_params
      params.require(:conversation).permit(:training_language, :native_language, :prompt_id)
    end
end
