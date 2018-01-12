module MarketoApi
  module API
    module Workspaces
      include Base

      def user_workspaces
        get("userservice/lm/v1/workspaces/")
      end
    end
  end
end
