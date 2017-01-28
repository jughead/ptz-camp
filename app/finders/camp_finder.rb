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

  def build
    model.new
  end
end
