require "httparty"
require "cdn_api_client/version"

class CDNsunCdnApiClient
  class InvalidParameters < StandardError; end

  include HTTParty

  base_uri "https://cdnsun.com/api/"
  format :json

  REQUEST_TIMEOUT = 60

  def initialize(username: , password: )
    raise InvalidParameters unless [username, password].all? do |arg|
      !arg.to_s.empty?
    end

    @username = username
    @password = password
  end

  def get(options = {})
    request(:get, options)
  end

  def put(options = {})
    request(:put, options)
  end

  def post(options = {})
    request(:post, options)
  end

  def delete(options = {})
    request(:delete, options)
  end

  def request(verb, options)
    options = Hash(options)

    if ![:get, :post, :put, :delete].include?(verb) ||
        options.empty? || "#{options[:url]}".empty?
      raise InvalidParameters
    end

    query_key, query = if body_needed?(verb)
      [:body, options[:data].to_json]
    else
      [:query, options[:data]]
    end

    resp = self.class.send(
      verb,
      format_url(options[:url]),
      basic_auth: { username: @username, password: @password },
      timeout: REQUEST_TIMEOUT,
      query_key => query,
      headers: { 'Content-Type' => 'application/json' }
    )

    resp.parsed_response
  end

  def body_needed?(verb)
    verb == :post || verb == :put
  end

  def format_url(url)
    "/#{url.sub(self.class.base_uri, '')}"
  end
end
