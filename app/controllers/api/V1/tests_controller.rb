module Api
  module V1
    class TestsController < BaseController
      before_action :authenticate_student!

      def index
        @tests = Test.all
      end

      def show
        @test = Test.find(id)
      end
    end
  end
end
