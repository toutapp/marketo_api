module MarketoApi
  module API
    module Activities
      include Base

      # Public: Returns a detailed describe result for the specified activities
      #
      # Example
      #   # get the describe for the Activities object
      #   client.activities_describe
      #   # => { ... }
      #
      # Returns the Hash representation of the describe call.
      def activities_describe
        api_get('activities/types.json')
      end

      def activities
      end

      def add_next_page_token(path, token)
        if token.present?
          path = path + "&nextPageToken=#{next_page_token}"
        end
        path
      end

      def activities_by_lead_ids(lead_ids, next_page_token=nil)
        lead_ids = format_filter_values(lead_ids)
        path = "activities.json?leadIds=#{lead_ids}"
        api_get(add_next_page_token(path, next_page_token))
      end

      def activities_by_type_id(type_ids, next_page_token=nil)
        type_ids = format_filter_values(type_ids)
        path = "activities.json?activityTypeIds=#{type_ids}"
        api_get(add_next_page_token(path, next_page_token))
      end

      def create_activity!(attrs)
        api_post('sales/activities.json', attrs)
      end
    end
  end
end
