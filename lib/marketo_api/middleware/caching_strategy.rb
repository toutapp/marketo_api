# frozen_string_literal: true

require 'digest/sha1'

module MarketoApi
  class Middleware::CachingStrategy < Faraday::HttpCache::Strategies::BaseStrategy
    def write(request, response)
      oauth_token = get_oauth_token(request)
      key = cache_key_for(request.url, oauth_token)
      entry = serialize_entry(request.serializable_hash, response.serializable_hash)
      entries = cache.read(key) || []
      entries = entries.dup if entries.frozen?
      entries.reject! do |(cached_request, cached_response)|
        response_matches?(request, deserialize_object(cached_request), deserialize_object(cached_response))
      end

      entries << entry

      cache.write(key, entries)
    rescue ::Encoding::UndefinedConversionError => e
      warn "Response could not be serialized: #{e.message}. Try using Marshal to serialize."
      raise e
    end

    def read(request)
      oauth_token = get_oauth_token(request)
      cache_key = cache_key_for(request.url, oauth_token)
      entries = cache.read(cache_key)
      response = lookup_response(request, entries)
      return nil unless response

      Faraday::HttpCache::Response.new(response)
    end

    def delete(request, url)
      oauth_token = get_oauth_token(request)
      cache_key = cache_key_for(request.url, oauth_token)
      cache.delete(cache_key)
    end

    # We don't want to cache requests for different clients, so append the
    # oauth token to the cache key.
    def cache_key_for(url, oauth_token)
      Digest::SHA1.hexdigest("#{@cache_salt}#{url}") + Digest::SHA1.hexdigest(oauth_token)
    end

    private

    def lookup_response(request, entries)
      if entries
        entries = entries.map { |entry| deserialize_entry(*entry) }
        _, response = entries.find { |req, res| response_matches?(request, req, res) }
        response
      end
    end

    def response_matches?(request, cached_request, cached_response)
      request.method.to_s == cached_request[:method].to_s &&
        vary_matches?(cached_response, request, cached_request)
    end

    def vary_matches?(cached_response, request, cached_request)
      headers = Faraday::Utils::Headers.new(cached_response[:response_headers])
      vary = headers['Vary'].to_s

      vary.empty? || (vary != '*' && vary.split(/[\s,]+/).all? do |header|
        request.headers[header] == cached_request[:headers][header]
      end)
    end

    def get_oauth_token(request)
      request.headers[MarketoApi::Middleware::Authorization::AUTH_HEADER]
    end
  end
end
