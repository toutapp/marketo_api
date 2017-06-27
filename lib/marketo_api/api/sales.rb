module MarketoApi
  module API
    module Sales
      include Base

      def best_bets(attrs)
        api_get('sales/bestbets.json', attrs)
      end

      def interesting_moments(attrs)
        api_get('sales/interestingmoments.json', attrs)
      end

      def create_activity!(attrs)
        api_post('sales/activities.json', attrs)
      end
    end
  end
end
