# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  name       :string
#  size       :integer
#  region_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class City < ApplicationRecord
  # Includes -------------------------------------------------------------------

  include CitiesFilter

  # Relations ------------------------------------------------------------------

  belongs_to :region

  has_many :metro_stations

  has_and_belongs_to_many :users

  # Methods --------------------------------------------------------------------

  def region_name
    region.name
  end
end
