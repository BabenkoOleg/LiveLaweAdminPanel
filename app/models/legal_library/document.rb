# == Schema Information
#
# Table name: legal_library_documents
#
#  id           :integer          not null, primary key
#  title        :string
#  free_content :text
#  category_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  paid_content :text
#  file         :string
#

class LegalLibrary::Document < ApplicationRecord
  # Includes -------------------------------------------------------------------

  mount_uploader :file, LegalLibrary::FileUploader

  # Relations ------------------------------------------------------------------

  belongs_to :category, class_name: 'LegalLibrary::Category'

  # Validations ----------------------------------------------------------------

  validates_presence_of :title
end
