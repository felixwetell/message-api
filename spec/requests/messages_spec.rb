RSpec.describe 'Messages API', type: :request do
  let!( :messages ) { create_list( :message, 10 ) }
  let( :message_id ) { messages.first.id }

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
        expect( JSON.parse( response.body ) ).not_to be_empty
        expect( JSON.parse( response.body )[ 'id' ] ).to eq( message_id )
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
    let( :valid_attributes ) { { title: 'New message', text: 'Saker som inte hänt', author: 'Felix Wetell' } }

    context 'when the request is valid' do
      before { post '/api/v1/messages', params: valid_attributes }

      it 'creates a message' do
        expect( JSON.parse( response.body )[ 'title' ] ).to eq( 'New message' )
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/messages', params: { title: 'Foobar' } }

      it 'returns status code 422' do
        expect( response ).to have_http_status( 422 )
      end

      it 'returns a validation failure message' do
        expect( response.body ).to match( "Validation failed: Text can't be blank, Author can't be blank" )
      end
    end
  end

  describe 'PUT /api/v1/messages/:id' do
    let( :valid_attributes ) { { title: 'Old message' } }

    context 'when the message exists' do
      before { put "/api/v1/messages/#{ message_id }", params: valid_attributes }

      it 'updates the message' do
        expect( response.body ).to be_empty
      end

      it 'returns status code 204' do
        expect( response ).to have_http_status( 204 )
      end
    end
  end

  describe 'DELETE /api/v1/messages/:id' do
    before { delete "/api/v1/messages/#{ message_id }" }

    it 'returns status code 204' do
      expect( response ).to have_http_status( 204 )
    end
  end
end