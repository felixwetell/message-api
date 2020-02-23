require 'notice'

module Api
  module V1
    class MessagesController < ApplicationController
      skip_before_action :authorize_request, only: [ :index, :show ]
      before_action :fetch_message, only: [ :show, :update, :destroy ]

      def index
        messages = Message.all
        json_response( messages )
      end

      def create
        @message = current_user.messages.new( message_params )
        @message.author = current_user.name
        @message.save!

        response = { message: Notice.message_created, object: @message }
        json_response( response, :created )
      end

      def show
        response = @message
        json_response( response )
      end

      def update
        @message.update( message_params )
        status = nil
        if @message.save
          response = { message: Notice.message_updated }
        else
          response = { errors: @message.errors.full_messages }
          status = :unprocessable_entity
        end

        json_response( response, status )
      end

      def destroy
        @message.destroy

        response = { message: Notice.message_deleted }
        json_response( response )
      end

      private

      def message_params
        params.permit( :title, :text )
      end

      def fetch_message
        @message = Message.find( params[ :id ] )
      end
    end
  end
end