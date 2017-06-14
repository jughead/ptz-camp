class Participant < ApplicationRecord
  belongs_to :camp
  belongs_to :delegation
  belongs_to :user, inverse_of: :participations

  attribute :personal, :personal_data, default: {}
  mount_uploader :passport_scan, PassportScanUploader
  enum tshirt: [:xs, :s, :m, :l, :xl, :xxl]

  delegate :name, to: :user

end
