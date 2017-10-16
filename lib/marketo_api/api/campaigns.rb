module MarketoApi
  module API
    module Campaigns
      include Base

      # Public: Executes specific entity request and returns the result.
      #
      # Example
      #   # Find the specific lead
      #   client.leads_by_id(318581)
      #   # => {
      #         "requestId": "10226#14d3049e51b",
      #         "success": true,
      #         "result": [
      #            {
      #               "id": 318581,
      #               "updatedAt":"2015-05-07T11:47:30-08:00"
      #               "lastName": "Doe",
      #               "email": "jdoe@marketo.com",
      #               "createdAt": "2015-05-01T16:47:30-08:00",
      #               "firstName": "John"
      #            }
      #         ]
      #      }
      #
      def campaign_by_id(id)
        api_get("campaigns/#{id}.json")
      end

      # Public: Returns a list of campaign records.
      # Required Permissions: Read-Only Campaigns, Read-Write Campaigns
      #
      # Example
      #   # Find the specific lead
      #   client.leads_by_filter_type('email',
      #                               ['abe@usa.gov', 'george@usa.gov'])
      #   # => {
      #     "requestId": "12951#15699db5c97",
      #     "result": [
      #       {
      #           "id": 318581,
      #           "updatedAt": "2016-05-17T22:11:45Z",
      #           "lastName": "Lincoln",
      #           "email": "abe@usa.gov",
      #           "createdAt": "2015-03-17T00:18:40Z",
      #           "firstName": "Abraham"
      #       },
      #       {
      #           "id": 318592,
      #           "updatedAt": "2016-05-17T22:20:51Z",
      #           "lastName": "Washington",
      #           "email": "george@usa.gov",
      #           "createdAt": "2015-04-06T16:29:21Z",
      #           "firstName": "George"
      #       }
      #     ],
      #     "success": true
      #   }
      #
      # If no records are found, the following is returned:
      # # => {
      #        "requestId": "177a1#1578b643357",
      #        "result": [],
      #        "success": true
      #      }
      #
      def campaigns_by_workspace(is_triggerable, workspace_name = 'Default')
        triggerable_param = "isTriggerable=#{is_triggerable ? 1 : 0}"
        workspace_param = "workspaceName=#{workspace_name}"
        api_get("campaigns.json?#{triggerable_param}&#{workspace_param}")
      end
    end
  end
end
