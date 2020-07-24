require 'rails_helper'

describe Api::V1::TestsController, type: :controller do
  render_views

  let(:user) { create :student }

  before do
    request.headers['Authorization'] = user.token
    request.headers['Accept'] = 'application/json'
    request.headers['Content-Type'] = 'application/json'
  end

  describe 'POST #create' do
    before do
      FactoryBot.create_list(:test, 3, user: create(:teacher))
    end

    def do_request
      get :index
    end

    it 'should return list of tests as json' do
      do_request
      expect(JSON.parse(response.body)["data"]["tests"].size).to eq 3
    end
  end

  describe 'GET #show' do
    let(:test) { create :test, user: create(:teacher) }

    def do_request
      get :show, params: { id: test.id }
    end

    it 'should render test details as json' do
      do_request
      expect(JSON.parse(response.body)["data"]["id"]).to eq test.id
    end
  end
end

