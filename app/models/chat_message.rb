# == Schema Information
#
# Table name: chat_messages
#
#  id          :integer          not null, primary key
#  text        :string
#  sender_id   :integer
#  sender_type :string
#  chat_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ChatMessage < ApplicationRecord
  # Relations ------------------------------------------------------------------

  belongs_to :sender, polymorphic: true
  belongs_to :chat
end
