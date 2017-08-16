class PublicFile < ApplicationRecord
  mount_uploader :data, FileUploader

  validates :title, presence: true
end
