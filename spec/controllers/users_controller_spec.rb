require 'rails_helper'

describe UsersController, type: :controller do
  before do
    allow_any_instance_of(CanCan::ControllerResource).to receive(:load_resource)
  end

  let(:teacher) { create :teacher }
  let!(:role_teacher) { Role.find_by_name('teacher') }
  let!(:role_student) { Role.find_by_name('student') }

  before { sign_in teacher }

  describe 'User not yet sign in' do
    before { sign_out teacher }

    def do_request
      get :index
    end

    it 'should redirect to login page' do
      do_request
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'GET #index' do
    before do
      FactoryBot.create_list(:teacher, 3)
      FactoryBot.create_list(:student, 3)
    end

    def do_request
      get :index
    end

    it 'should be show list of users' do
      do_request
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    def do_request
      get :new
    end

    it 'should be render template :new' do
      do_request
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    let(:user) { create :user }

    def do_request
      post :create, params: { user: user_params }
    end

    context 'valid params' do
      let(:user_params) { attributes_for :user, role_ids: [role_teacher, role_student].sample.id }

      it 'should be create user successfully' do
        do_request
        expect(response).to redirect_to users_path
        expect(flash[:notice]).to eq I18n.t('flash_message.user.create.success')
      end
    end

    context 'invalid params' do
      let(:user_params) { attributes_for :user, name: nil, role_ids: [role_teacher, role_student].sample.id }

      it 'should be render :new with error(s)' do
        do_request
        expect(assigns[:user].errors.present?).to eq true
        expect(assigns[:user].errors.full_messages.to_sentence).to eq "Name can't be blank"
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #show' do
    context 'user is valid' do
      let(:user) { create :student }

      def do_request
        get :show, params: { id: user.id }
      end

      it 'should be render template :show' do
        do_request
        expect(response).to render_template :show
      end
    end

    context 'user is invalid' do
      def do_request
        get :show, params: { id: 0 }
      end

      it 'should be raise error' do
        expect { do_request }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'GET #edit' do
    let(:user) { create(:student) }

    def do_request
      get :edit, params: { id: user.id }
    end

    it 'should be render template :edit' do
      do_request
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    let(:user) { create(:student) }

    def do_request
      patch :update, params: { id: user.id, user: user_attributes }
    end

    context 'valid params' do
      let(:user_attributes) { attributes_for(:user, name: 'correct') }

      it 'should be update user successfully' do
        do_request
        expect(user.reload.name).to eq 'correct'
        expect(flash[:notice]).to eq I18n.t('flash_message.user.update.success')
        expect(response).to redirect_to user_path(user)
      end
    end

    context 'invalid params' do
      let(:user_attributes) { attributes_for(:user, name: '') }

      it 'should be render :edit with error' do
        do_request
        expect(assigns[:user].errors.present?).to eq true
        expect(assigns[:user].errors.full_messages.to_sentence).to eq "Name can't be blank"
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create :student }

    context 'valid user' do
      def do_request
        delete :destroy, params: { id: user.id }
      end

      it 'should be delete user successfully' do
        expect { do_request }.to change{ User.count }.from(2).to(1)
      end
    end

    context 'invalid user' do
      def do_request
        delete :destroy, params: { id: 0 }
      end

      it 'should be raise error' do
        expect { do_request }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
