module MarketoApi
  module API
    module Leads
      include Base

      # Public: Returns a detailed describe result for the specified leads
      #
      # Example
      #   # get the describe for the Leads object
      #   client.leads_describe
      #   # => { ... }
      #
      # Returns the Hash representation of the describe call.
      def leads_describe
        api_get('leads/describe.json')
      end

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
      def leads_by_id(id)
        api_get("leads/#{id}.json")
      end

      # Public: Executes specific filterType with filterValues request
      # and returns the result.
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
      def leads_by_filter_type(filter_type, filter_values)
        type_param = "filterType=#{filter_type}"
        values_param = "filterValues=#{format_filter_values(filter_values)}"
        api_get("leads.json?#{type_param}&#{values_param}")
      end
    end
  end
end
