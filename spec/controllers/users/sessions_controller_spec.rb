require 'rails_helper'

describe Users::SessionsController, type: :controller do
  describe 'POST #create' do
    def do_request
      post :create, params: { email: user.email, password: user.password }
    end

    context 'teacher login' do
      let(:user) { create :teacher }

      before do
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        @request.env["devise.mapping"] = Devise.mappings[:user]
      end

      it 'should redirect to dashboard' do
        do_request
        expect(response).to redirect_to users_path
      end
    end

    context 'student login' do
      let(:user) { create :student }

      before do
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        @request.env["devise.mapping"] = Devise.mappings[:user]
      end

      it 'should log out and redirect to sign in page' do
        do_request
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
