require 'rails_helper'

RSpec.describe 'Authentication' do
  describe 'POST /login' do
    let!( :user ) { create( :user ) }
    let( :headers ) { valid_headers.except( 'Authorization' ) }
    let( :valid_credentials ) do
      {
          name: user.name,
          password: user.password
      }.to_json
    end
    let( :invalid_credentials ) do
      {
          name: Faker::Internet.name,
          password: Faker::Lorem.word
      }.to_json
    end

    context 'when request is valid' do
      before { post '/login', params: valid_credentials, headers: headers }

      it 'returns an authentication token' do
        expect( json[ 'auth_token' ] ).not_to be_nil
      end
    end

    context 'when request is invalid' do
      before { post '/login', params: invalid_credentials, headers: headers }

      it 'returns a failure message' do
        expect( json[ 'message' ] ).to match( /Invalid credentials/ )
      end
    end
  end
end