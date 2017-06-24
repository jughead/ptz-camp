class PersonalData < ApplicationStruct

  def self.attributes
    @attributes ||= [:passport_number,
    :passport_issue_date,
    :passport_expire_date,
    :first_name,
    :last_name,
    :middle_names,
    :latin_name,
    :country_permanent,
    :region_permanent,
    :address_permanent,
    :visa_city,
    :place_of_work,
    :work_address,
    :occupation,
    :points_to_visit].freeze
  end

  attr_accessor *(self.attributes - [:passport_issue_date, :passport_expire_date])
  attribute :passport_issue_date, :date
  attribute :passport_expire_date, :date

  def attributes
    self.class.attributes.map{|key| [key, public_send(key)]}.to_h
  end

  def attribute_names
    self.class.attributes
  end
end
