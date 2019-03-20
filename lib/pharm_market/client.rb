module PharmMarket
  class Client
    attr_reader :data, :logger

    def initialize(options)
      @data = OpenStruct.new(options)
      @logger = PharmMarket.configuration.logger
      validate_keys
    end

    def create
      log do
        response = connection.post('/cb/check/send') do |req|
          req.headers['Content-Type'] = 'application/json'
          req.headers['Authorization'] = "Bearer #{PharmMarket.configuration.token}"
          req.body = data.to_h.except(:id).to_json
        end
        logger.clear_tags! if logger.respond_to?(:clear_tags!)
        Response.new(response)
      end
    end

    private

    def connection
      @connection ||= ::Faraday.new(url: PharmMarket.configuration.host) do |faraday|
        faraday.response :json, parser_options: { symbolize_names: true }
        faraday.use Faraday::Request::UrlEncoded
        faraday.use Faraday::Response::Logger, logger,
                    bodies: PharmMarket.configuration.log_bodies
        faraday.options.open_timeout = 2
        faraday.options.timeout = 5
        faraday.adapter :net_http
      end
    end

    def validate_keys
      diff = %i[id fd fpd sum] - data.to_h.keys
      raise KeyError, "Missing key #{diff.join(', ')}" if diff.count > 0
    end

    def log
      response = yield
      logger.info(id: data.id, body: response.body, code: response.status,
                  conflict: response.conflict?)
      response
    end
  end
end
