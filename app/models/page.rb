class Page < ApplicationRecord
  belongs_to :camp

  enum state: [:draft, :openned, :closed]

  validates_with Pages::SlugValidator

  scope :global, -> { where(camp_id: nil) }
  scope :menu, -> { openned.ordered }
  scope :ordered, -> { order(:order) }
end
