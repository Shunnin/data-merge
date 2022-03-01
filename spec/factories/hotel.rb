FactoryBot.define do
  factory :hotel do
    sequence(:hotel_id) { |n| "hotel_id_#{n}" }
    destination_id      { 'destination_id' }

    before(:create) do |hotel|
      hotel.details = {
        id: hotel.hotel_id,
        destination_id: hotel.destination_id,
        name: 'Beach Villas Singapore',
        location_lat: 1.264751,
        location_lng: 103.824006,
        location_address: '8 Sentosa Gateway, Beach Villas, 098269',
        location_city: 'Singapore',
        location_country: 'Singapore'
      }
    end
  end
end
