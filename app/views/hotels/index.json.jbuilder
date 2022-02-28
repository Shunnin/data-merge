json.ignore_nil!

json.data do
  json.array! @hotels do |hotel|
    json.id                 hotel.id
    json.destination_id     hotel.destination_id
    json.name               hotel.name
    json.location           hotel.location
    json.description        hotel.description
    json.images do
      json.rooms     hotel.images[:rooms]
      json.site      hotel.images[:site]
      json.amenities hotel.images[:amenities]
    end
    json.amenities do
      json.general hotel.amenities[:general]
      json.room    hotel.amenities[:room]
    end
    json.booking_conditions hotel.booking_conditions
  end
end
