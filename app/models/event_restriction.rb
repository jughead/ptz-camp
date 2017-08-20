class EventRestriction < ApplicationRecord
  belongs_to :event1, class_name: 'Event'
  belongs_to :event2, class_name: 'Event'

  after_save :add_opposite_restriction
  after_destroy :remove_opposite_restriction

  private

  def add_opposite_restriction
    unless EventRestriction.unscoped.where(event1_id: event2_id, event2_id: event1_id).exists?
      EventRestriction.create!(event1_id: event2_id, event2_id: event1_id)
    end
  end

  def remove_opposite_restriction
    EventRestriction.unscoped.where(event1_id: event2_id, event2_id: event1_id).delete_all
  end
end
