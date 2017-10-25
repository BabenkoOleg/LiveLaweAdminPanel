# == Schema Information
#
# Table name: metro_stations
#
#  id         :integer          not null, primary key
#  name       :string
#  city_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MetroStation < ApplicationRecord
  # Relations ------------------------------------------------------------------

  belongs_to :city
end
