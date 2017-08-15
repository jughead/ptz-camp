class CampConstraint
  def matches?(request)
    request.format.html? && slug_list.include?(request.params[:slug])
  end

  def slug_list
    Rails.cache.fetch(:camp_constraint, expires_in: 1.minute) do
      Camp.pluck(:slug)
    end
  end
end
