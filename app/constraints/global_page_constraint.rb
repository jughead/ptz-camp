class GlobalPageConstraint
  def matches?(request)
    request.format.html? && slug_list.include?(request.params[:slug])
  end

  def slug_list
    Rails.cache.fetch(:slug_constraint, expires_in: 1.minute) do
      Page.global.pluck(:slug)
    end
  end
end
