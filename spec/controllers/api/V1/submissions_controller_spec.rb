require 'rails_helper'

describe Api::V1::SubmissionsController, type: :controller do
  render_views

  describe 'POST #create' do
    let(:user) { create :student }

    before do
      request.headers['Authorization'] = user.token
      request.headers['Accept'] = 'application/json'
      request.headers['Content-Type'] = 'application/json'
    end

    def do_request
      post :create, params: {}
    end

    it 'should return message as json' do
      do_request
      expect(response.body).to eq JSON.generate({ success: true, data: { message: 'Your answers saved successfully.'}  })
    end
  end
end

