module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :verify_authenticity_token
      def create
        creator_service = UserManager::Creator.new(user_params)
        result = creator_service.call
        if result[:success]
          render json: result[:resource], status: :created
        else
          render json: { error: result[:error_message] }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:cpf,:name,:telephone,:email)
      end

    end
  end
end
