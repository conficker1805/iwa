class Test
  class Option < ApplicationRecord
    # Associations
    belongs_to :question, class_name: 'Test::Question', optional: true
  end
end
