class Response
  attr_reader :response

  delegate :body, :status, to: :response

  def initialize(response)
    @response = response
  end

  def good?
    status == 200
  end

  def conflict?
    !success? && (body.try(:[], :error) || []).find { |error| error.match?('уже зарегистрирован') }.present?
  end

  def success?
    good? && body.try(:[], :success).present?
  end
end
