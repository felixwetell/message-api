module Api
  module V1
    class UsersController < ApplicationController
      def create
        user = User.create!( user_params )
        auth_token = AuthenticateUser.new( user.name, user.password ).call
        response = { message: Notice.account_created, auth_token: auth_token }
        json_response( response, :created )
      end

      private

      def user_params
        params.permit( :name, :password, :password_confirmation )
      end
    end
  end
end