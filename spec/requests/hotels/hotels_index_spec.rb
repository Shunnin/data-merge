require 'rails_helper'

describe 'hotels#index (GET /api/hotels)' do
  def send_request(params = {})
    send(:get, "/api/hotels?#{params.to_query}")
  end

  context 'when hotel exist' do
    let!(:hotels) do
      [
        create_list(:hotel, 3, destination_id: 5432),
        create_list(:hotel, 2, destination_id: 1122),
      ].flatten
    end

    context 'with searches all' do
      it 'returns all hotels' do
        send_request

        expected_hotel_ids = hotels.pluck(:hotel_id)
        result = body_json['data']

        expect(response).to have_http_status(:success)
        expect(result.count).to eq(hotels.count)
        expect(result.map { |h| h['id'] }).to eq(expected_hotel_ids)
      end
    end

    context 'with searches by hotel id' do
      it 'returns all hotels has id is the same as given hotel id' do
        send_request({ hotels: [hotels.first.hotel_id, hotels.last.hotel_id] })

        expected_hotel = [hotels.first, hotels.last]
        expected_hotel_ids = expected_hotel.pluck(:hotel_id)
        result = body_json['data']

        expect(response).to have_http_status(:success)
        expect(result.count).to eq(expected_hotel.count)
        expect(result.map { |h| h['id'] }).to eq(expected_hotel_ids)
      end
    end

    context 'with searches by destination id' do
      it 'returns all hotels has destination id is the same as given destination id' do
        send_request({ destination: [hotels.first.destination_id] })

        expected_hotel = hotels.filter { |h| h.destination_id == hotels.first.destination_id }
        expected_hotel_ids = expected_hotel.pluck(:hotel_id)
        result = body_json['data']

        expect(response).to have_http_status(:success)
        expect(result.count).to eq(expected_hotel.count)
        expect(result.map { |h| h['id'] }).to eq(expected_hotel_ids)
      end
    end

  end

  context 'when has no hotel' do
    it 'returns empty list' do
      send_request

      expect(response).to have_http_status(:success)
      expect(body_json['data']).to be_empty
    end
  end
end
