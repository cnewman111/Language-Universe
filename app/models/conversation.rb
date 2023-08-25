class Conversation < ApplicationRecord
  include ConversationsHelper
  belongs_to :prompt
  belongs_to :user
  has_many :messages, dependent: :destroy
  validates :training_language, :native_language, :prompt_id, :user_id, presence: :true
  scope :visible_by_user, -> (user) {where('user_id == ?', user.id)}


  def create_responses 
    translator_respond
    character_respond
  end 

  private
    def character_respond
      client = OpenAI::Client.new
      dialouge = [{role: 'system', content: "You are playing the character in the following setting: " + prompt.setting + 
                  ".  Respond to the user's inputs only in the following language: " + training_language + ".  Do not break character."}]

      self.messages.each do |m|
        if m.creating_entity == Message::ENTITIES[0]
          dialouge.push({ role: Message::ENTITIES[0], content: m.body})
        elsif m.creating_entity == Message::ENTITIES[2]
          dialouge.push({ role: 'assistant', content: m.body})
        end 
      end 

      message_body = client.chat(
      parameters: {
            model: MODEL,
            messages: dialouge,
            temperature: TEMPERATURE
      }).dig('choices', 0, 'message', 'content' )

      self.messages.create(creating_entity: Message::ENTITIES[1], body: message_body)
    end

    def translator_respond
      client = OpenAI::Client.new
      dialouge = [
                      {role: 'system', content: "You will be given a conversation in the following language: " + prompt.setting + 
                      ".  Your task is to fix the gramatical errors in the LAST MESSAGE.  If you cannot determine what they were trying to say, respond with 'error'"},
                    ]

      self.messages.each do |m|
        if m.creating_entity == Message::ENTITIES[0]
          dialouge.push({ role: Message::ENTITIES[0], content: m.body})
        elsif m.creating_entity == Message::ENTITIES[1]
          dialouge.push({ role: 'assistant', content: m.body})
        end 
      end 

      message_body = client.chat(
        parameters: {
              model: MODEL,
              messages: dialouge,
              temperature: 0
      }).dig('choices', 0, 'message', 'content' )  

      self.messages.create(creating_entity: Message::ENTITIES[2], body: message_body)
    end
end
