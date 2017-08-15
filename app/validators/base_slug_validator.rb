class BaseSlugValidator < ActiveModel::Validator
  # Collecting first segments of all routes
  RESERVED = Rails.application.routes.routes.map do |route|
    route.path.spec.to_s.split('(').first.split('/').second
  end.reject do |segment|
    # rejecting blank and dynamic segments
    !segment || segment[0] == ':' || segment[0] == '*'
  end.uniq.freeze

  REGEXP = /\A[\w-]+\z/.freeze

  def validate(record)
    check_format(record)
    check_usage(record)
    check_reserved(record)
  end

  def check_usage(record)
    raise NotImplementedError
  end

  def check_reserved(record)
    if RESERVED.include?(record.slug)
      record.errors.add(:slug, :exclusion, value: record.slug)
    end
  end

  def check_format(record)
    if record.slug !~ REGEXP
      record.errors.add(:slug, :invalid, value: record.slug)
    end
  end
end
