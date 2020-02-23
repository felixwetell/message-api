require 'rails_helper'

RSpec.describe 'Messages API', type: :request do
  let( :user ) { create( :user ) }
  let!( :messages ) { create_list( :message, 10, author: user.name, user_id: user.id ) }
  let( :message_id ) { messages.first.id }

  let( :headers ) { valid_headers }

  describe 'GET /api/v1/messages' do
    before { get '/api/v1/messages' }

    it 'returns messages' do
      expect( JSON.parse( response.body ) ).not_to be_empty
      expect( JSON.parse( response.body ).size ).to eq( 10 )
    end

    it 'returns status code 200' do
      expect( response ).to have_http_status( 200 )
    end
  end

  describe 'GET /api/v1/messages/:id' do
    before { get "/api/v1/messages/#{ message_id }" }

    context 'when the message exists' do
      it 'returns the message' do
        expect( json ).not_to be_empty
        expect( json[ 'id' ] ).to eq( message_id )
      end

      it 'returns status code 200' do
        expect( response ).to have_http_status( 200 )
      end
    end

    context 'when the message does not exist' do
      let( :message_id ) { 100 }

      it 'returns status code 404' do
        expect( response ).to have_http_status( 404 )
      end

      it 'returns a not found message' do
        expect( response.body ).to match( "Couldn't find Message with 'id'=#{ message_id }" )
      end
    end
  end

  describe 'POST /api/v1/messages' do
    let( :valid_attributes ) do
      {
          title: 'New message',
          text: 'Saker som inte hänt',
          author: user.name,
          user_id: user.id
      }.to_json
    end

    context 'when the request is valid' do
      before { post '/api/v1/messages', params: valid_attributes, headers: headers }

      it 'creates a message' do
        expect( json[ 'message' ] ).to match( /Message created/ )
        expect( json[ 'object' ][ 'title' ] ).to eq( 'New message' )
      end

      it 'returns status code 201' do
        expect( response ).to have_http_status( 201 )
      end
    end

    context 'when the request is invalid' do
      let( :invalid_attributes ) do
        { title: 'Foobar' }.to_json
      end
      before { post '/api/v1/messages', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect( response ).to have_http_status( 422 )
      end

      it 'returns a validation failure message' do
        expect( response.body ).to match( /Text can't be blank/ )
      end
    end
  end

  describe 'PUT /api/v1/messages/:id' do
    let( :valid_attributes ) do
      { title: 'Old message' }.to_json
    end

    context 'when the message exists' do
      before { put "/api/v1/messages/#{ message_id }", params: valid_attributes, headers: headers }

      it 'updates the message' do
        expect( json[ 'message' ] ).to match( /Message updated/ )
      end

      it 'returns status code 200' do
        expect( response ).to have_http_status( 200 )
      end
    end
  end

  describe 'DELETE /api/v1/messages/:id' do
    before { delete "/api/v1/messages/#{ message_id }", params: {}, headers: headers }

    it 'deletes the message' do
      expect( json[ 'message' ] ).to match( /Message deleted/ )
    end

    it 'returns status code 200' do
      expect( response ).to have_http_status( 200 )
    end
  end
end