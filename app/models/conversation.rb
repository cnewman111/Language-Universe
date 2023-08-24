class Conversation < ApplicationRecord
  include ConversationsHelper
  belongs_to :prompt
  belongs_to :user
  has_many :messages, dependent: :destroy
  validates :training_language, :native_language, :prompt_id, :user_id, presence: :true
  scope :visible_by_user, -> (user) {where('user_id == ?', user.id)}

  def ai_respond
    print "HERE1"
    client = OpenAI::Client.new
    dialouge = [{role: "user", content: "Hello!"}]
    # self.messages.each do |m|
    #   dialouge.push({ role: m.creating_entity})
    # end 

    print "HERE2"

    message_body = client.chat(
    parameters: {
          model: MODEL,
          messages: dialouge,
          temperature: TEMPERATURE
    }).dig("choices", 0, "message", "content")

    self.messages.create(creating_entity: Message::ENTITIES[1], body: message_body)

    print "HERE3"
    print message_body
  end 
end
