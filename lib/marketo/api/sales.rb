module Marketo
  module API
    module Sales
      include Base

      def best_bets(attrs)
        api_get('sales/bestbets.json', attrs)
      end

      def add_next_page_token(path, token)
        if token.present?
          path = path + "&nextPageToken=#{next_page_token}"
        end
        path
      end

      def create_activity!(attrs)
        api_post('sales/activities.json', attrs)
      end
    end
  end
end
