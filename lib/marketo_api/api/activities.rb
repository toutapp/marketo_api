require 'time'

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

      def paging_token(start_time)
        if start_time.present?
          mod_time = start_time.iso8601
        else
          mod_time = Time.now.iso8601
        end
        api_get("activities/pagingtoken.json?sinceDatetime=#{mod_time}")
      end

      def add_activity_type_ids(type_ids)
        ids = format_filter_values(type_ids)
        if ids.present?
          "activityTypeIds=#{ids}"
        else
          ""
        end
      end

      def activities_by_lead_ids(lead_ids, type_ids, next_page_token=nil)
        path = "activities.json"
        path << "?leadIds=#{format_filter_values(lead_ids)}" if lead_ids.present?
        path << "&#{add_activity_type_ids(type_ids)}" if type_ids.present?
        api_get(add_next_page_token(path, next_page_token))
      end

      def activities_by_type_id(type_ids, next_page_token=nil)
        path = "activities.json"
        path << "?#{add_activity_type_ids(type_ids)}" if type_ids.present?
        api_get(add_next_page_token(path, next_page_token))
      end
    end
  end
end
