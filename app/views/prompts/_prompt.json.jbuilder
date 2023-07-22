json.extract! prompt, :id, :ai_name, :setting, :training_language, :native_language, :description, :user_id, :visible_to_all, :created_at, :updated_at
json.url prompt_url(prompt, format: :json)
