module Marketo
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
    end
  end
end
