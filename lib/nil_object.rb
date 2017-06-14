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

  def method_missing?(a)
    self
  end
end
