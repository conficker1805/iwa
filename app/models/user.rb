class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  # has_many :tests, dependent: :destroy

  # Validations
  validates :name, presence: true
  validate :has_role
  validate :valid_downgrade

  # User must have a role
  def has_role
    errors.add(:role_ids, :must_have) if roles.size != 1
  end

  # User cannot downgrade anyone else account to Student if they have any test
  def valid_downgrade
    # errors.add(:role_ids, :fail_downgrade) if has_role? :teacher && tests.any?
  end
end
