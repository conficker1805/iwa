require 'rails_helper'

describe TestsController, type: :controller do
  before do
    allow_any_instance_of(CanCan::ControllerResource).to receive(:load_resource)
  end

  let(:teacher) { create :teacher }

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
      FactoryBot.create_list(:test, 3, user: teacher)
    end

    def do_request
      get :index
    end

    it 'should be show list of tests' do
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
    def do_request
      post :create, params: { test: test_params }
    end

    context 'valid params' do
      let(:test_params) { attributes_for :test }

      it 'should be create test successfully' do
        do_request
        expect(response).to redirect_to tests_path
        expect(flash[:notice]).to be_present
      end
    end

    context 'invalid params' do
      let(:test_params) { attributes_for :test, name: nil }

      it 'should be render :new with error(s)' do
        do_request
        expect(assigns[:test].errors.present?).to eq true
        expect(assigns[:test].errors.full_messages.to_sentence).to eq "Name can't be blank"
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #show' do
    context 'test is valid' do
      let(:test) { create :test, user: teacher }

      def do_request
        get :show, params: { id: test.id }
      end

      it 'should be render template :show' do
        do_request
        expect(response).to render_template :show
      end
    end

    context 'test is invalid' do
      def do_request
        get :show, params: { id: 0 }
      end

      it 'should be raise error' do
        expect { do_request }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'GET #edit' do
    let(:test) { create(:test, user: teacher) }

    def do_request
      get :edit, params: { id: test.id }
    end

    it 'should be render template :edit' do
      do_request
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    let(:test) { create(:test, user: teacher) }

    def do_request
      patch :update, params: { id: test.id, test: test_attributes }
    end

    context 'valid params' do
      let(:test_attributes) { attributes_for(:test, name: 'correct') }

      it 'should be update test successfully' do
        do_request
        expect(test.reload.name).to eq 'correct'
        expect(flash[:notice]).to be_present
        expect(response).to redirect_to test_path(test)
      end
    end

    context 'invalid params' do
      let(:test_attributes) { attributes_for(:test, name: '') }

      it 'should be render :edit with error' do
        do_request
        expect(assigns[:test].errors.present?).to eq true
        expect(assigns[:test].errors.full_messages.to_sentence).to eq "Name can't be blank"
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create :teacher }
    let!(:test) { create :test, user: user }

    context 'valid test' do
      def do_request
        delete :destroy, params: { id: test.id }
      end

      it 'should be delete test successfully' do
        expect { do_request }.to change{ Test.count }.from(1).to(0)
        expect(flash[:notice]).to be_present
      end
    end

    context 'invalid test' do
      def do_request
        delete :destroy, params: { id: 0 }
      end

      before { sign_in user }

      it 'should be raise error' do
        expect { do_request }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
