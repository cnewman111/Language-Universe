require "application_system_test_case"

class PromptsTest < ApplicationSystemTestCase
  setup do
    @prompt = prompts(:one)
  end

  test "visiting the index" do
    visit prompts_url
    assert_selector "h1", text: "Prompts"
  end

  test "should create prompt" do
    visit prompts_url
    click_on "New prompt"

    fill_in "Ai name", with: @prompt.ai_name
    fill_in "Description", with: @prompt.description
    fill_in "Native language", with: @prompt.native_language
    fill_in "Setting", with: @prompt.setting
    fill_in "Training language", with: @prompt.training_language
    fill_in "User", with: @prompt.user_id
    check "Visible to all" if @prompt.visible_to_all
    click_on "Create Prompt"

    assert_text "Prompt was successfully created"
    click_on "Back"
  end

  test "should update Prompt" do
    visit prompt_url(@prompt)
    click_on "Edit this prompt", match: :first

    fill_in "Ai name", with: @prompt.ai_name
    fill_in "Description", with: @prompt.description
    fill_in "Native language", with: @prompt.native_language
    fill_in "Setting", with: @prompt.setting
    fill_in "Training language", with: @prompt.training_language
    fill_in "User", with: @prompt.user_id
    check "Visible to all" if @prompt.visible_to_all
    click_on "Update Prompt"

    assert_text "Prompt was successfully updated"
    click_on "Back"
  end

  test "should destroy Prompt" do
    visit prompt_url(@prompt)
    click_on "Destroy this prompt", match: :first

    assert_text "Prompt was successfully destroyed"
  end
end
