class GuestUser < User
  include Singleton

  def new_record?
    true
  end

  def persisted?
    false
  end

  def participations
    NilObject.instance
  end

  def guest?
    true
  end
end
