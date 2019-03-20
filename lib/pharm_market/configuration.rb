module PharmMarket
  class Configuration
    attr_accessor :host, :token, :logger, :log_bodies

    def initialize
      @log_bodies = false
      @logger = Logger.new(STDOUT)
    end
  end
end
