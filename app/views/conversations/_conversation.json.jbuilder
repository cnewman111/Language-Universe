json.extract! conversation, :id, :training_language, :native_language, :prompt_id, :user_id, :created_at, :updated_at
json.url conversation_url(conversation, format: :json)
