class PersonalData
  include ActiveModel::Model

  attr_accessor :passport_number,
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
    :points_to_visit

  def attributes
    instance_values
  end
end
