module HotelServices
  class GetHotels < BaseService

    def initialize(search_params)
      @hotel_ids = search_params[:hotels]
      @destination = search_params[:destination]
    end

    def execute
      search_by_criteria(Hotel.all)
    end

    private

    def search_by_criteria(scope)
      new_scope = search_by_hotel_ids(scope)
      new_scope = search_by_destination(new_scope)

      new_scope
    end

    def search_by_hotel_ids(scope)
      return scope if @hotel_ids.blank?

      scope.where(hotel_id: @hotel_ids)
    end

    def search_by_destination(scope)
      return scope if @destination.blank?

      scope.where(destination_id: @destination)
    end

  end
end