class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  rolify
  after_create :assign_default_role

  has_many :messages, dependent: :destroy

  def admin?
    self.has_role?(:admin)
  end

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end
end