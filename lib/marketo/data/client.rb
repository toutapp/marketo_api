module Marketo
  module Data
    class Client < AbstractClient
      # Public: Returns a url to the resource.
      #
      # resource - A record that responds to to_sparam or a String/Fixnum.
      #
      # Returns the url to the resource.
      def url(resource)
        resource_name_for_url =
          if resource.respond_to?(:to_sparam)
            resource.to_sparam
          else
            resource
          end

        "#{instance_url}/#{resource_name_for_url}"
      end
    end
  end
end
