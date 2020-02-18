require 'rails_helper'

RSpec.describe 'Message requests' do
  describe 'GET /messages' do
    it 'returns all messages' do
      get( '/messages' )
      messages = JSON.parse( response.body )
      expect( json[ 'status' ] ).to eql( :ok )
    end
  end
end