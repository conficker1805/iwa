require 'rails_helper'

describe Test::Question do
  describe 'Associations' do
    it { should belong_to :test }
    it { should have_many :options }
  end

  describe 'Validations' do
    it { should validate_presence_of(:label) }
  end

  describe '#valid_options' do
    let(:test) { create :test, user: create(:teacher) }

    context 'question without options' do
      let(:question) { Test::Question.new(attributes_for :question, test_id: test.id, options_attributes: []) }

      it 'should render error' do
        question.save
        expect(question.errors.full_messages.to_sentence).to include I18n.t('activerecord.errors.models.test/question.attributes.label.need_more_option')
      end
    end

    context 'question without correct answer' do
      let(:question) do
        Test::Question.new(attributes_for :question, test_id: test.id, options_attributes:
          [
            attributes_for(:option, correctness: false),
            attributes_for(:option, correctness: false)
          ]
        )
      end

      it 'should render error' do
        question.save
        expect(question.errors.full_messages.to_sentence).to include I18n.t('activerecord.errors.models.test/question.attributes.label.must_have_correct_answer')
      end
    end
  end
end
