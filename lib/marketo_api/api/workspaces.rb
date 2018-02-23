module MarketoApi
  module API
    module Workspaces
      include Base

      # Public: Returns an array of workspaces for the current user.
      # Example
      # client.user_workspaces
      # => [{
      #       "id": 102,
      #       "name": "A cool Marketo workspace",
      #       "description": "This workspace is amazing!",
      #       "globalViz": 0,
      #       "status": "active",
      #       "currencyInfo": nil,
      #       "createdAt": "20180112T18:07:09.0t+0000",
      #       "updatedAt": "20180112T18:07:09.0t+0000"
      #    }]

      def user_workspaces
        get("userservice/lm/v1/workspaces/")
      end
    end
  end
end
