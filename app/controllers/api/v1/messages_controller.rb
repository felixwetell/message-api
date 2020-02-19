module Api
  module V1
    class MessagesController < ApplicationController
      before_action :fetch_message, only: [ :show, :update, :destroy ]

      def index
        messages = Message.all
        json_response( messages )
      end

      def create
        message = Message.create!( message_params )
        if message.save
          json_response( message, :created )
        else
          json_response( message.errors.full_messages, :unprocessable_entity )
        end
      end

      def show
        json_response( @message )
      end

      def update
        @message.update( message_params )
        if message.save
          json_response( @message, :no_content )
        else
          json_response( @message.errors.full_messages, :unprocessable_entity )
        end
      end

      def destroy
        @message.destroy
        json_response( 'Message deleted', :no_content )
      end

      private

      def message_params
        params.permit( :title, :text, :author )
      end

      def fetch_message
        @message = Message.find( params[ :id ] )
      end
    end
  end
end