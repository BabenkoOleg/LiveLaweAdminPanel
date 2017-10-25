# == Schema Information
#
# Table name: questions
#
#  id          :integer          not null, primary key
#  title       :string
#  text        :text
#  charged     :boolean          default(FALSE)
#  category_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Question < ApplicationRecord
  # Includes -------------------------------------------------------------------

  include QuestionsFilter

  # Relations ------------------------------------------------------------------

  belongs_to :user
  belongs_to :category
end
