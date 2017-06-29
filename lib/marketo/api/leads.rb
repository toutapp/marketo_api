module Marketo
  module API
    module Leads
      include Base

      def lead_by_email(email)
        api_get("leads.json?filterType=email&filterValues=#{email}")
      end

      def lead_by_id(id)
        api_get("leads/#{id}.json")
      end

      def lead_by_salesforce_crm_id(crm_id)
        api_get("leads.json?filterType=sfdcLeadId&filterValues=#{crm_id}")
      end
    end
  end
end
