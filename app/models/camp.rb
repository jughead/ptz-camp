class Camp < ApplicationRecord
  validates :title, presence: true
  validates :telegram_intro, presence: true
  validates :slug, presence: true, uniqueness: true
end
