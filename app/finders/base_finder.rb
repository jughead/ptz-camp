class BaseFinder
  def find
    raise NotImplementedError
  end

  def find!
    find || raise(ActiveRecord::RecordNotFound)
  end

  def find_or_build
    find || build
  end

  def find_or_create!
    object = find_or_build
    object&.save!
    object
  end

  def find_or_create
    object = find_or_build
    object&.save
    object
  end
end
