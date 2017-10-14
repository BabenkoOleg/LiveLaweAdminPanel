# == Schema Information
#
# Table name: legal_library_documents
#
#  id          :integer          not null, primary key
#  category_id :integer
#  title       :string
#  body        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class LegalLibrary::Document < ApplicationRecord
  # Relations ------------------------------------------------------------------

  belongs_to :category, class_name: 'LegalLibrary::Category'
end
