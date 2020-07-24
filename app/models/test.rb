class Test < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :questions, dependent: :destroy

  accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: :all_blank

  # Validations
  validates :name, presence: true
  validate :valid_questions

  def valid_questions
    errors.add(:name, :need_more_question) if questions.size.zero?
  end
end
