module MarketoApi
  class Middleware::Caching < Faraday::HttpCache
    def call(env)
      unless use_cache?
        expire(@strategy.cache_key_for(
                 env[:url],
                 env[:request_headers][MarketoApi::Middleware::Authorization::AUTH_HEADER]
               ))
      end
      super
    end

    def expire(key)
      @strategy.delete(key)
    end

    def delete(request, response)
      headers = %w[Location Content-Location]
      headers.each do |header|
        url = response.headers[header]
        @strategy.delete(request, url) if url
      end

      @strategy.delete(request, request.url)
      trace :delete
    end

    def use_cache?
      @options.fetch(:use_cache, true)
    end
  end
end
