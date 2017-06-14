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
      model.order(start_date: :desc).first
    end
  end

  def find_by_slug(slug)
    model.where(slug: slug).first
  end

  def find_by_slug!(slug)
    model.where(slug: slug).take!
  end

  def build
    model.new
  end
end
