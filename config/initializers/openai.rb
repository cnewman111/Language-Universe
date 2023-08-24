OpenAI.configure do |config|
    config.access_token = Rails.application.credentials[:OPENAI_KEY]
    config.request_timeout = 30
end