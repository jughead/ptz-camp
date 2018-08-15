class GuestUser < User
  include Singleton

  def new_record?
    true
  end

  def persisted?
    false
  end

  def present?
    false
  end

  def participations
    Participations.instance
  end

  def guest?
    true
  end

  def has_role?(*)
    false
  end

  class Participations
    include Singleton

    def first_or_initialize(options={})
      new(options)
    end

    def new(options={})
      Participation.new({user: GuestUser.instance}.merge(options))
    end

    def build(options={})
      new(options)
    end

    def where(*)
      self
    end

    def joins(*)
      self
    end

    def select(*)
      self
    end

    def group(*)
      self
    end

    def first
      nil
    end

    def last
      nil
    end

    def [](*)
      nil
    end

    def blank?
      true
    end

    def present?
      false
    end
  end
end
