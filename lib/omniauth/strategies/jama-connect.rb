require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class JamaConnect < OmniAuth::Strategies::OAuth2
      option :name, 'jama_connect'
      option :scope, 'token_information'
      option :origin_param, 'redirect_uri'
      option :client_options, {
        auth_scheme: :basic_auth,
      }

      # Connect is multi-tenant, so the host needs to be set by the implementer.
      option :host, nil

      uid do
        request.params['code']
      end

      def request_phase
        raise NoHostError if options[:host].nil?

        options.client_options[:authorize_url] = options[:host] += '/authorize.req'
        super
      end

      def callback_phase
        raise NoHostError if options[:host].nil?

        options.client_options[:token_url] = options[:host] += '/rest/oauth/token'
        super
      end

      def query_string
        # Need to override query_string here or else Connect complains about
        # a mismatch URI. The query string is non-determinate, and omniauth
        # adds it for the third leg of the journey
        ''
      end
    end

    class NoHostError < StandardError
      def initialize
        super(
          'No host option set. Make sure you add the host option when you'\
          ' initialize the strategy, or use a setup Proc for dynamically setting'\
          ' the host.'
        )
      end
    end
  end
end

OmniAuth.config.add_camelization 'jama_connect', 'JamaConnect'
