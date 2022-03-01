class SearchHotelParam < BaseParam

  attr_accessor :hotels, :destination

  def initialize(params = {})
    @hotels = params[:hotels]
    @destination = params[:destination]

    params.permit(:hotels, :destination)
  end

end