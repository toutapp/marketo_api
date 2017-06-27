module MarketoApi
  module API
    module Stats
      include Base

      # Public: Returns the daily usage of API requests
      #
      # Example
      #   client.daily_usage
      #   # => { ... }
      #
      # Returns the Hash representation of the usage call.
      def daily_usage
        api_get('stats/usage.json')
      end

      # Public: Returns the count of each error type encountered
      # in the current day
      #
      # Example
      #   client.daily_errors
      #   # => { ... }
      #
      # Returns the Hash representation of the usage call.
      def daily_errors
        api_get('stats/errors.json')
      end

      # Public: Returns a list of API users and the number of calls
      # they have consumed in the past 7 days.
      #
      # Example
      #   client.weekly_usage
      #   # => { ... }
      #
      # Returns the Hash representation of the usage call.
      def weekly_usage
        api_get('stats/usage/last7days.json')
      end

      # Public: Returns a list of API users and a count of each error type
      # they have encountered in the past 7 days
      #
      # Example
      #   client.weekly_errors
      #   # => { ... }
      #
      # Returns the Hash representation of the usage call.
      def weekly_errors
        api_get('stats/errors/last7days.json')
      end
    end
  end
end
