module MarketoApi
  module API
    module Workspaces
      include Base

      def get_workspaces
        get("userservice/lm/v1/workspaces/")
      end
    end
  end
end
