require 'rails_helper'

describe Test do
  describe 'Associations' do
    it { should belong_to :user }
    it { should have_many :questions }
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
  end

  describe '#valid_questions' do
    let(:test) { Test.new(attributes_for :test, user_id: create(:teacher).id) }

    context 'test has question(s)' do
      it 'should create test successfully' do
        expect { test.save }.to change{ Test.count }.from(0).to(1)
      end
    end

    context 'test has no questions' do
      let(:test) { Test.new(attributes_for :test, user_id: create(:teacher).id, questions_attributes: []) }

      it 'should render error' do
        expect { test.save }.not_to change{ Test.count }
        expect(test.errors.full_messages.to_sentence).to include I18n.t('activerecord.errors.models.test.attributes.name.need_more_question')
      end
    end
  end
end
