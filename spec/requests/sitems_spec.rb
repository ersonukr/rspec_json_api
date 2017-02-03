require 'rails_helper'

RSpec.describe 'Sitems API' do
  # Initialize the test data
  let!(:stodo) { create(:stodo) }
  let!(:sitems) { create_list(:sitem, 20, stodo_id: stodo.id) }
  let(:stodo_id) { stodo.id }
  let(:id) { sitems.first.id }

  # Test suite for GET /todos/:todo_id/items
  describe 'GET /stodos/:stodo_id/sitems' do
    before { get "/stodos/#{stodo_id}/sitems" }

    context 'when stodo exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all stodo sitems' do
        expect(json.size).to eq(20)
      end
    end

    context 'when stodo does not exist' do
      let(:stodo_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Stodo/)
      end
    end
  end

  # Test suite for GET /todos/:todo_id/items/:id
  describe 'GET /stodos/:stodo_id/sitems/:id' do
    before { get "/stodos/#{stodo_id}/sitems/#{id}" }

    context 'when stodo sitem exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the sitem' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when stodo sitem does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Sitem/)
      end
    end
  end

  # Test suite for PUT /todos/:todo_id/items
  describe 'POST /stodos/:stodo_id/sitems' do
    let(:valid_attributes) { { name: 'Visit Narnia', done: false } }

    context 'when request attributes are valid' do
      before { post "/stodos/#{stodo_id}/sitems", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/stodos/#{stodo_id}/sitems", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /todos/:todo_id/items/:id
  describe 'PUT /stodos/:stodo_id/sitems/:id' do
    let(:valid_attributes) { { name: 'Mozart' } }

    before { put "/stodos/#{stodo_id}/sitems/#{id}", params: valid_attributes }

    context 'when sitem exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the sitem' do
        updated_sitem = Sitem.find(id)
        expect(updated_sitem.name).to match(/Mozart/)
      end
    end

    context 'when the sitem does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Sitem/)
      end
    end
  end

  # Test suite for DELETE /todos/:id
  describe 'DELETE /stodos/:id' do
    before { delete "/stodos/#{stodo_id}/sitems/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end