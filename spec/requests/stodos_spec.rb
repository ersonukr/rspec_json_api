require 'rails_helper'

RSpec.describe 'Stodos API', type: :request do
  # initialize test data
  let!(:stodos) { create_list(:stodo, 10) }
  let(:stodo_id) { stodos.first.id }

  # Test suite for GET /todos
  describe 'GET /stodos' do
    # make HTTP get request before each example
    before { get '/stodos' }

    it 'returns stodos' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /todos/:id
  describe 'GET /stodos/:id' do
    before { get "/stodos/#{stodo_id}" }

    context 'when the record exists' do
      it 'returns the stodo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(stodo_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:stodo_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Stodo/)
      end
    end
  end

  # Test suite for POST /todos
  describe 'POST /stodos' do
    # valid payload
    let(:valid_attributes) { {title: 'Learn Elm', created_by: '1'} }

    context 'when the request is valid' do
      before { post '/stodos', params: valid_attributes }

      it 'creates a stodo' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/stodos', params: {title: 'Foobar'} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  # Test suite for PUT /todos/:id
  describe 'PUT /stodos/:id' do
    let(:valid_attributes) { {title: 'Shopping'} }

    context 'when the record exists' do
      before { put "/stodos/#{stodo_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /todos/:id
  describe 'DELETE /stodos/:id' do
    before { delete "/stodos/#{stodo_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end