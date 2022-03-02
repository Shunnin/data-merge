module MergingServices
  module Hotel
    class BlendingWorker < GBlendingData::BlendingWorker

      protected

      def get_noise_data(id)
        HotelSupplierProcedure.
          where(source_id: id, state: SupplierProcedure.states[:noise]).
          pluck(:value)
      end

      def handle_blending_success(result)
        ActiveRecord::Base.transaction do
          ::Hotel.create_or_update!({ hotel_id: result[:id] }, {
            destination_id: result[:destination_id],
            details:        result,
          })

          HotelSupplierProcedure.
            where(source_id: result[:id]).
            update_all(state: SupplierProcedure.states[:clean])
        end
      rescue => e
        # Error handler
      end

      def config
        @config ||= {
          id: { },
          destination_id: { },
          name: {
            merge_strategies: {
              text_matching: true,
            },
          },
          description: { },
          location_lat: {
            merge_strategies: {
              valid_format: RegexPattern::REGEX_LATITUDE,
              text_matching: true,
            },
          },
          location_lng: {
            merge_strategies: {
              valid_format: RegexPattern::REGEX_LONGITUDE,
              text_matching: true,
            },
          },
          location_address: {
            merge_strategies: {
              text_matching: true,
            },
          },
          location_city: {
            merge_strategies: {
              text_matching: true,
            },
          },
          location_country: {
            merge_strategies: {
              text_matching: true,
            },
          },
          amenities_general: {
            merge_strategies: {
              combine: true,
            }
          },
          amenities_room: {
            merge_strategies: {
              combine: true,
            }
          },
          images_rooms: {
            merge_strategies: {
              combine: {
                uniq_key: :link
              },
            }
          },
          images_site: {
            merge_strategies: {
              combine: {
                uniq_key: :link
              },
            }
          },
          images_amenities: {
            merge_strategies: {
              combine: {
                uniq_key: :link
              },
            }
          },
          booking_conditions: {
            merge_strategies: {
              combine: true,
            }
          },
        }.freeze
      end

    end
  end
end