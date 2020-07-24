class Test
  class Question < ApplicationRecord
    # Associations
    belongs_to :test
    has_many :options, dependent: :destroy, class_name: 'Test::Option'

    accepts_nested_attributes_for :options, allow_destroy: true, reject_if: proc { |a| a['label'].blank? }

    # Validations
    validates :label, presence: true
    validate :valid_options

    def valid_options
      if options.size.zero?
        errors.add(:label, :need_more_option)
      elsif !options.map(&:correctness).include?(true)
        errors.add(:label, :must_have_correct_answer)
      end
    end
  end
end
