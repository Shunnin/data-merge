class HotelsController < ApplicationController

  def index
    search_params = validate!(SearchHotelParam)
    result = HotelServices::GetHotels.execute(search_params)

    @hotels = result.map { |hotel| HotelPresenter.new(hotel) }
  end

end