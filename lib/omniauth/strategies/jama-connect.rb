require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class JamaConnect < OmniAuth::Strategies::OAuth2
      option :name, 'jama_connect'
      option :host, nil
      option :scope, 'token_information'
      option :client_options, {
        auth_scheme: :basic_auth,
      }

      uid do
        request.params["code"]
      end

      def request_phase
        options.client_options[:authorize_url] = options[:host] += '/authorize.req'
        super
      end

      def callback_phase
        options.client_options[:token_url] = options[:host] += '/rest/oauth/token'
        super
      end

      def query_string
        # TODO: Determine if we need a redirect URI for Connect. Otherwise, we need to override query_string here 
        # or else Connect complains about a mismatch URI (because of the query string)
        ""
      end
    end
  end
end

OmniAuth.config.add_camelization 'jama_connect', 'JamaConnect'
