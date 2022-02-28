class HotelsController < ApplicationController

  def index
    result = HotelServices::GetHotels.execute(build_search_hotel_params)

    @hotels = result.map { |hotel| HotelPresenter.new(hotel) }
  end

  private

  def build_search_hotel_params
    {
      hotels: params[:hotels],
      destination: params[:destination],
    }
  end

end