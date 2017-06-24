class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: PtzCamp::OmniAuth.providers

  include Users::OldSite

  has_many :messages, dependent: :destroy
  has_many :identities, dependent: :destroy
  has_many :participations, class_name: 'Participant', inverse_of: :user, dependent: :destroy

  rolify

  validates :name, presence: true

  after_create :assign_default_role

  add_command :new_with_session
  add_command :sync_omniauth_email_verification

  def admin?
    has_role?(:admin)
  end

  def superadmin?
    has_role?(:superadmin)
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

  def guest?
    false
  end
end
