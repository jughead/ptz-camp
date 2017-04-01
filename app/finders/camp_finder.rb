class CampFinder < BaseFinder
  def model
    Camp
  end

  def current
    # TODO: use year and season
    @current = true
    self
  end

  def find
    if @current
      model.order(created_at: :desc).first
    end
  end

  def find_by_slug(slug)
    model.where(slug: slug).first
  end

  def build
    model.new
  end
end
