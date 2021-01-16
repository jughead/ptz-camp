# frozen_string_literal: true

class PersonalData < ApplicationStruct
  include ActiveModel::Validations
  include ActiveModel::Dirty

  def self.attributes
    @attributes ||= %i[passport_number
                       passport_issue_date
                       passport_expire_date
                       first_name
                       last_name
                       middle_names
                       latin_name
                       country_permanent
                       region_permanent
                       address_permanent
                       visa_city
                       place_of_work
                       work_address
                       occupation
                       points_to_visit
                       needs_visa
                       birth_date
                       sex
                       citizenship
                       birth_country
                       birth_place
                       passport_issuer
                       food_limitations
                       share_with_partners].freeze
  end

  attr_accessor(*(attributes - %i[passport_issue_date passport_expire_date needs_visa birth_date share_with_partners]))

  attribute :passport_issue_date, :date
  attribute :passport_expire_date, :date
  attribute :birth_date, :date
  attribute :needs_visa, :boolean
  attribute :share_with_partners, :boolean

  validates :first_name, :last_name, presence: true
  validates :birth_date, presence: true
  validate :validate_birth_date_beginning
  validate :validate_share_with_partners

  validates :passport_number,
    :passport_issue_date,
    :passport_expire_date,
    :latin_name,
    :country_permanent,
    :region_permanent,
    :address_permanent,
    :visa_city,
    :place_of_work,
    :work_address,
    :points_to_visit,
    :citizenship,
    :birth_country,
    :birth_place,
    :passport_issuer,
    presence: true, if: :needs_visa
  validates :sex, inclusion: { in: %w[male female] }, if: :needs_visa

  def attributes
    self.class.attributes.map { |key| [key, public_send(key)] }.to_h
  end

  def attribute_names
    self.class.attributes
  end

  def valid?(*args)
    puts "Valid called with: #{args}"
    super
  end

  private

  def validate_birth_date_beginning
    return unless birth_date

    errors.add(:birth_date, :young) if birth_date > Date.parse('2010-12-31')
  end

  def validate_share_with_partners
    return unless share_with_partners.nil?

    errors.add(:share_with_partners, :blank)
  end
end
