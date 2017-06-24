class NilObject
  include Singleton

  def blank?
    true
  end

  def nil?
    true
  end

  def present?
    false
  end

  def ==(value)
    value.nil?
  end

  def method_missing(a, *args)
    self
  end

  def respond_to?(a)
    true
  end
end
