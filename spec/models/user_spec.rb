require 'rails_helper'

describe User do
  describe 'Associations' do
    it { should have_many :tests }
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
  end

  describe '#has_role' do
    let!(:teacher) { Role.find_by_name('teacher') }
    let!(:student) { Role.find_by_name('student') }

    context 'Create user without role assignment' do
      let(:user) { User.new(attributes_for :student, role_ids: []) }

      it 'should render error' do
        user.save
        expect(user.errors.full_messages.to_sentence).to include I18n.t('activerecord.errors.models.user.attributes.role_ids.must_have')
      end
    end

    context 'Create a student' do
      let(:user) { User.new(attributes_for(:student).merge(role_ids: student.id)) }

      it 'should create user successfully' do
        expect { user.save! }.to change{ User.count }.from(0).to(1)
        expect(user.roles.first.name).to eq 'student'
      end
    end

    context 'Create teacher student' do
      let(:user) { User.new(attributes_for(:teacher).merge(role_ids: teacher.id)) }

      it 'should create user successfully' do
        expect { user.save! }.to change{ User.count }.from(0).to(1)
        expect(user.roles.first.name).to eq 'teacher'
      end
    end
  end

  describe '#valid_downgrade' do
    let(:teacher) { create :teacher }

    def do_request
      teacher.role_ids = Role.find_by_name('student').id
      teacher.save
    end

    context 'change from Teacher to Student' do
      context 'Teacher have tests' do
        let!(:test) { create(:test, user_id: teacher.id) }

        it 'should return error' do
          do_request
          expect(teacher.errors.full_messages.to_sentence).to include I18n.t('activerecord.errors.models.user.attributes.role_ids.fail_downgrade')
        end
      end

      context 'Teacher do not have tests' do
        it 'should downgrade successfully' do
          expect(teacher.errors.full_messages).to eq []
        end
      end
    end
  end

  describe '#role' do
    let(:role) { %w[teacher student].sample }
    let(:user) { create role.to_sym }

    it 'should return role name' do
      expect(user.role).to eq role
    end
  end

  describe '#token' do
    let(:student) { create :student }

    it 'should return encrypted token' do
      expect(student.token.length).to eq 107
    end
  end
end
