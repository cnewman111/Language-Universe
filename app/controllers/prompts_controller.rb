class PromptsController < ApplicationController
  include PromptsHelper
  before_action :set_prompt, only: %i[ show edit update destroy ]

  # GET /prompts or /prompts.json
  def index
    @prompts = Prompt.visible_to_user(current_or_guest_user)
  end

  # GET /prompts/1 or /prompts/1.json
  def show
  end

  # GET /prompts/new
  def new
    if user_signed_in?
      @prompt = Prompt.new
    else
      redirect_to new_user_session_path, notice: "Please log in to create a prompt."
    end 
  end

  # GET /prompts/1/edit
  def edit
    if !user_can_modify(@prompt, current_or_guest_user)
      redirect_to prompts_path
    end 
  end

  # POST /prompts or /prompts.json
  def create
    @prompt = Prompt.new(prompt_params)
    @prompt.user = current_or_guest_user

    if user_can_modify(@prompt, current_or_guest_user) && @prompt.save
      redirect_to prompt_url(@prompt), notice: "Prompt was successfully created." 
    else 
      render :new, status: :unprocessable_entity
    end 
  end

  # PATCH/PUT /prompts/1 or /prompts/1.json
  def update
    if user_can_modify(@prompt, current_or_guest_user) && @prompt.update(prompt_params)
      redirect_to prompt_url(@prompt), notice: "Prompt was successfully updated." 
    else 
      render :edit, status: :unprocessable_entity 
    end 
  end

  # DELETE /prompts/1 or /prompts/1.json
  def destroy
    if user_can_modify(@prompt, current_or_guest_user)
      @prompt.destroy
      redirect_to prompts_url, notice: "Prompt deleted"
    else 
      redirect_to prompt_url(@prompt)
    end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prompt
      @prompt = Prompt.visible_to_user(current_or_guest_user).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def prompt_params
      params.require(:prompt).permit(:ai_name, :setting, :description, :visible_to_all)
    end
end
