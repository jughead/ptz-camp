class Participant < ApplicationRecord
  belongs_to :camp
  belongs_to :delegation
  belongs_to :user, inverse_of: :participations
  belongs_to :team
  has_many :event_participations, dependent: :destroy
  rolify

  attribute :personal, :personal_data, default: {}
  mount_uploader :passport_scan, PassportScanUploader
  enum tshirt: [:xs, :s, :m, :l, :xl, :xxl]

  validates :user, presence: true, on: :user
  validates :name, presence: true
  validates :tshirt, presence: true
  validates :delegation, presence: true
  validates :delegation_id, presence: true
  validates :camp, presence: true
  validates :camp_id, presence: true
  validates_associated :personal

  scope :without_team, ->(team=nil) { Participants::WithoutTeamQuery.new(team).query }
  scope :ordered_by_delegation, -> { order(:delegation_id) }
  scope :ordered_by_name, -> { order("personal->>'first_name', personal->>'last_name'")}

  def user
    super || GuestUser.instance
  end

  def name
    (personal.first_name.to_s + " " + personal.last_name.to_s).strip
  end

  def self.roles
    @roles ||= [:participant, :coach, :guest, :organizer].freeze
  end

end
