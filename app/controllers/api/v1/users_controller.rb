module Api
  module V1
    class UsersController < ApplicationController
      def create
        user = User.create!( user_params )
        if user.save
          json_response( user, :created )
        else
          json_response( user.errors.full_messages, :unprocessable_entity )
        end
      end

      private

      def user_params
        params.require( :user ).permit( :name, :password_digest )
      end
    end
  end
end