module MarketoApi
  module API
    module Campaigns
      include Base

      # Public: Executes specific entity request and returns the result.
      #
      # Example
      #   # Find the specific campaign
      #   client.campaign_by_id(3711)
      #   # => {
      #          "requestId": "717#15f4b51ed20"
      #          "success": "true"
      #          "result": [
      #            {
      #              "id": "3711"
      #              "name": "John Clark - Smart Campaign"
      #              "type": "trigger"
      #              "programName": "John Clark - Request Campaign.John Clark - Email Program"
      #              "programId": "1073"
      #              "workspaceName": "Default"
      #              "createdAt": "'2017-02-13T19:58:56Z'"
      #              "updatedAt": "'2017-02-13T20:06:29Z'"
      #              "active": "true"
      #            }
      #          ]
      #        }
      def campaign_by_id(id)
        api_get("campaigns/#{id}.json")
      end

      # Public: Returns a list of campaign records.
      # Required Permissions: Read-Only Campaigns, Read-Write Campaigns
      #
      # Example
      #   # Find the specific campaign
      #   client.campaigns_by_workspace(true)
      #   # => {
      #          "requestId": "cab#15f4b36d1ca"
      #          "success": "true"
      #          "result": [
      #            {
      #              "id": "3711"
      #              "name": "John Clark - Smart Campaign"
      #              "type": "trigger"
      #              "programName": "John Clark - Request Campaign.John Clark - Email Program"
      #              "programId": "1073"
      #              "workspaceName": "Default"
      #              "createdAt": "'2017-02-13T19:58:56Z'"
      #              "updatedAt": "'2017-02-13T20:06:29Z'"
      #              "active": "true"
      #            }
      #          ]
      #        }
      #
      # If no records are found, the following is returned:
      # # => {
      #        "requestId": "13cc0#15f4b5134af",
      #        "result": [],
      #        "success": true
      #      }
      #
      def campaigns_by_workspace(is_triggerable, workspace_name = 'Default')
        triggerable_param = "isTriggerable=#{is_triggerable ? 1 : 0}"
        workspace_param = "workspaceName=#{workspace_name}"
        api_get("campaigns.json?#{triggerable_param}&#{workspace_param}")
      end

      # Public: Passes a set of leads to a trigger campaign to run through the campaign's flow.
      # The designated campaign must have a Campaign is Requested: Web Service API trigger, and
      # must be active. My tokens local to the campaign's parent program can be overridden for
      # the run to customize content.
      #
      # Required Permissions: Execute Campaign
      #
      #
      # Example
      #   # Add lead to trigger campaign
      #   client.trigger_campaign!(3711, {})
      #   # => {
      #          "errors": [
      #            {
      #              "code": 0,
      #              "message": "string"
      #            }
      #          ],
      #          "moreResult": false,
      #          "nextPageToken": "string",
      #          "requestId": "string",
      #          "result": [
      #            {
      #              "active": false,
      #              "createdAt": "string",
      #              "description": "string",
      #              "id": 0,
      #              "name": "string",
      #              "programId": 0,
      #              "programName": "string",
      #              "type": "batch",
      #              "updatedAt": "string",
      #              "workspaceName": "string"
      #            }
      #          ],
      #          "success": false,
      #          "warnings": [
      #            {
      #              "code": 0,
      #              "message": "string"
      #            }
      #          ]
      #        }
      def trigger_campaign!(campaign_id, attrs)
        api_post("campaigns/#{campaign_id}/trigger.json", attrs)
      end
    end
  end
end
