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
        json_response( message, :created )
      end

      def show
        json_response( @message )
      end

      def update
        @message.update( message_params )
        head :no_content
      end

      def destroy
        @message.destroy
        head :no_content
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