module MarketoApi
  module Concerns
    module Verbs
      # Internal: Define methods to handle a verb.
      #
      # verbs - A list of verbs to define methods for.
      #
      # Examples
      #
      #   define_verbs :get, :post
      #
      # Returns nil.
      def define_verbs(*verbs)
        verbs.each do |verb|
          define_verb(verb)
          define_api_verb(verb)
        end
      end

      # Internal: Defines a method to handle HTTP requests with the passed in
      # verb.
      #
      # verb - Symbol name of the verb (e.g. :get).
      #
      # Examples
      #
      #   define_verb :get
      #   # => get '/rest/v1/leads'
      #
      # Returns nil.
      def define_verb(verb)
        define_method verb do |*args, &block|
          begin
            connection.send(verb, *args, &block)
          rescue MarketoApi::UnauthorizedError
            raise
          end
        end
      end

      # Internal: Defines a method to handle HTTP requests with the passed in
      # verb to a marketo api endpoint.
      #
      # verb - Symbol name of the verb (e.g. :get).
      #
      # Examples
      #
      #   define_api_verb :get
      #   # => api_get 'leads'
      #
      # Returns nil.
      def define_api_verb(verb)
        define_method :"api_#{verb}" do |*args, &block|
          args[0] = api_path(args[0])
          send(verb, *args, &block)
        end
      end
    end
  end
end
