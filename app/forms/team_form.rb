class TeamForm < SimpleDelegator
  include ActiveModel::Naming
  include ActiveModel::Validations

  alias_method :team, :__getobj__

  validates :delegation, presence: true
  validates :camp, presence: true
  validate :participants_not_used
  validate :cant_create_empty

  private

  def participants_not_used
    return if participants.left_joins(:teams).merge(Team.where.not(id: id)).size == 0
    errors.add(:participants, :used)
  end

  def cant_create_empty
    return if participants.present?
    errors.add(:participants, :empty)
  end
end


