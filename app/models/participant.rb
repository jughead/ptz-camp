class Participant < ApplicationRecord
  belongs_to :camp
  belongs_to :delegation
  belongs_to :user, inverse_of: :participations

  attribute :personal, :personal_data, default: {}
  mount_uploader :passport_scan, PassportScanUploader
  enum tshirt: [:xs, :s, :m, :l, :xl, :xxl]

  validates :user, presence: true
  validates :name, presence: true
  validates :tshirt, presence: true
  validates :delegation, presence: true
  validates :delegation_id, presence: true
  validates :camp, presence: true
  validates :camp_id, presence: true

  delegate :name, to: :user

  def user
    super || GuestUser.instance
  end

end
