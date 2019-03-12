require "test_helper"

class JamaConnectTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil OmniAuth::Jama::Connect::VERSION
  end

  def test_it_requires_a_host_for_request_phase
    strategy = OmniAuth::Strategies::JamaConnect.new({})
    assert_raises(OmniAuth::Strategies::NoHostError) { strategy.request_phase }
  end

  def test_it_requires_a_host_for_callback_phase
    strategy = OmniAuth::Strategies::JamaConnect.new({})
    assert_raises(OmniAuth::Strategies::NoHostError) { strategy.callback_phase }
  end

  def test_it_uses_host_in_authorize_url
    strategy = OmniAuth::Strategies::JamaConnect.new({}, host: 'http://fakecompany.jamaland.com')

    begin
      strategy.request_phase
    rescue NoMethodError # We don't care about the internals of what's happening in OmniAuth 
      assert_equal strategy.options.client_options[:authorize_url], 'http://fakecompany.jamaland.com/authorize.req'
    end
  end

  def test_it_uses_host_in_token_url
    strategy = OmniAuth::Strategies::JamaConnect.new({}, host: 'http://fakecompany.jamaland.com')

    begin
      strategy.callback_phase
    rescue NoMethodError # We don't care about the internals of what's happening in OmniAuth 
      assert_equal strategy.options.client_options[:token_url], 'http://fakecompany.jamaland.com/rest/oauth/token'
    end
  end
end
