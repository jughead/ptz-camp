# frozen_string_literal: true

class Team < ApplicationRecord
  belongs_to :camp
  belongs_to :delegation
  has_many :participants

  validates :name, presence: true
  validates :camp, presence: true

  scope :ordered_by_name, -> { order(:name) }

  before_destroy do
    participants.update_all(team_id: nil)
  end

  def self.define_flag(name)
    @@flag_counter ||= 0
    id = @@flag_counter
    @@flag_counter += 1
    define_method "#{name}=" do |value|
      if value == 'true' || value == '1'
        set_flag(id)
      else
        unset_flag(id)
      end
    end

    define_method name do
      get_flag(id)
    end
  end

  define_flag :with_display
  define_flag :keyboard
  define_flag :mouse

  private

  def set_flag(id)
    self.flags ||= 0
    self.flags |= (1 << id)
  end

  def unset_flag(id)
    self.flags ||= 0
    self.flags &= ~(1 << id)
  end

  def get_flag(id)
    flags && (flags & (1 << id)) > 0
  end
end
