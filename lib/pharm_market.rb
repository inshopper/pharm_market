require 'faraday'
require 'faraday-encoding'
require 'faraday_middleware'
require 'active_support'
require 'active_support/core_ext'
require 'pharm_market/version'
require 'pharm_market/client'
require 'pharm_market/configuration'
require 'pharm_market/response'

module PharmMarket
  class << self
    def configuration
      @configuration ||= PharmMarket::Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
