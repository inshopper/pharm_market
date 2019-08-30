class Response
  attr_reader :response

  delegate :body, :status, to: :response

  def initialize(response)
    @response = response
  end

  def conflict?
    failure? && conflict_error?
  end

  def error?
    failure? && !conflict_error?
  end

  private

  def conflict_error?
    err = body.try(:[], :error)
    return err.match?('уже зарегистрирован') if err.is_a?(String)
    (err || []).find { |error| error.match?('уже зарегистрирован') }.present?
  end

  def failure?
    body.try(:[], :success).blank?
  end
end
