# frozen_string_literal: true

class Participant < ApplicationRecord
  belongs_to :camp
  belongs_to :delegation
  belongs_to :user, inverse_of: :participations
  belongs_to :team
  has_many :event_participations, dependent: :destroy
  rolify

  attribute :personal, :personal_data, default: {}
  mount_uploader :passport_scan, PassportScanUploader
  enum tshirt: { xs: 0, s: 1, m: 2, l: 3, xl: 4, xxl: 5 }

  validates :user, presence: true, on: :user
  validates :name, presence: true
  validates :tshirt, presence: true
  validates :delegation, presence: true
  validates :delegation_id, presence: true
  validates :camp, presence: true
  validates :camp_id, presence: true
  validates_associated :personal

  scope :without_team, ->(team = nil) { Participants::WithoutTeamQuery.new(team).query }
  scope :ordered_by_delegation, -> { order(:delegation_id) }
  scope :ordered_by_name, -> { order("personal->>'first_name', personal->>'last_name'") }
  scope :ordered_by_last_name, -> { order("personal->>'last_name'") }
  scope :ordered_by_first_name, -> { order("personal->>'first_name'") }
  scope :match_first_name, ->(collection) { where("(personal->>'first_name') IN (?)", collection) }
  scope :match_last_name, ->(collection) { where("(personal->>'last_name') IN (?)", collection) }

  def user
    super || GuestUser.instance
  end

  def name
    (personal.first_name.to_s + ' ' + personal.last_name.to_s).strip
  end

  def self.roles
    @roles ||= %i[participant coach guest organizer].freeze
  end
end
