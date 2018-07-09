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

      def paging_token(start_time)
        # FIXME: (MT) Need to make sure `start_time` is a `Time` obj
        if start_time
          mod_time = start_time.iso8601
        else
          mod_time = Time.now.iso8601
        end

        api_get("activities/pagingtoken.json?sinceDatetime=#{mod_time}")
      end

      def add_activity_type_ids(type_ids)
        ids = format_filter_values(type_ids)
        if ids
          "activityTypeIds=#{ids}"
        else
          ""
        end
      end

      # FIXME: (MT) Refactor this
      def activities_by_lead_ids(lead_ids, type_ids, next_page_token=nil)
        # FIXME: (MT) Raise an error when lead_ids is empty
        path = "activities.json"
        path << "?leadIds=#{format_filter_values(lead_ids)}" if lead_ids
        path << "&#{add_activity_type_ids(type_ids)}" if type_ids
        api_get(add_next_page_token(path, next_page_token))
      end

      # FIXME: (MT) Refactor this
      def activities_by_type_id(type_ids, next_page_token=nil)
        # FIXME: (MT) Rename method to support plural (type_ids)
        # FIXME: (MT) Raise an error when type_ids is empty
        path = "activities.json"
        path << "?#{add_activity_type_ids(type_ids)}" if type_ids
        api_get(add_next_page_token(path, next_page_token))
      end
    end
  end
end
