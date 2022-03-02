class HotelPresenter

  def initialize(hotel)
    @hotel = hotel
    @hotel_details = @hotel.details&.symbolize_keys || {}
  end

  def id
    @hotel_details[:id]
  end

  def destination_id
    @hotel_details[:destination_id]
  end

  def name
    @hotel_details[:name]
  end

  def description
    @hotel_details[:description]
  end

  def location
    {
      lat: @hotel_details[:location_lat],
      lng: @hotel_details[:location_lng],
      address: @hotel_details[:location_address],
      city: @hotel_details[:location_city],
      country: @hotel_details[:location_country],
    }
  end

  def amenities
    {
      general: @hotel_details[:amenities_general],
      room: @hotel_details[:amenities_room],
    }
  end

  def images
    {
      rooms: @hotel_details[:images_rooms],
      site: @hotel_details[:images_site],
      amenities: @hotel_details[:images_amenities],
    }
  end

  def booking_conditions
    @hotel_details[:booking_conditions]
  end

end