module Api
  module V1
    class SubmissionsController < BaseController
      before_action :authenticate_student!

      def create
      end

      protected

      def test_id
        params.require(:submission).require(:test_id)
      end

      def submission_params
        params.require(:submission).permit(questions: [:question_id, answer_ids: []])
      end
    end
  end
end
