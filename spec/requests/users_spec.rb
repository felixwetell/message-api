RSpec.describe 'Users API', type: :request do
  let!( :users ) { create_list( :user, 10 ) }
  let( :user_id ) { users.first.id }

  describe 'POST /api/v1/users' do
    let( :valid_attributes ) { { name: 'name', password: 'password' } }

    context 'when the request is valid' do
      before { post '/api/v1/users', params: valid_attributes }

      it 'creates a user' do
        expect( JSON.parse( response.body )[ 'name' ] ).to eq( 'name' )
      end

      it 'returns status code 201' do
        expect( response ).to have_http_status( 201 )
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/users', params: { name: 'Foobar' } }

      it 'returns status code 422' do
        expect( response ).to have_http_status( 422 )
      end

      it 'returns a validation failure user' do
        expect( response.body ).to match( "Validation failed: Password can't be blank" )
      end
    end
  end
end