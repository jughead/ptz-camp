class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: PtzCamp::OmniAuth.providers

  include Users::OldSite

  has_many :messages, dependent: :destroy
  has_many :identities, dependent: :destroy

  rolify

  validates :name, presence: true

  after_create :assign_default_role

  add_command :new_with_session
  add_command :sync_omniauth_email_verification

  def admin?
    has_role?(:admin)
  end

  def assign_default_role
    add_role(:user) if roles.blank?
  end

  def self.new_with_session(params, session)
    super.new_with_session(params, session)
  end

  def password_required?
    identities.blank? && super
  end
end
