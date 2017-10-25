# == Schema Information
#
# Table name: bought_categories
#
#  id                 :integer          not null, primary key
#  category_id        :integer
#  user_id            :integer
#  payment_expiration :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class BoughtCategory < ApplicationRecord
  # Relations ------------------------------------------------------------------

  belongs_to :user
  belongs_to :category
end
