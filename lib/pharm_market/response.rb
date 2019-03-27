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
    failure? && body.try(:[], :error).present? && !conflict_error?
  end

  private

  def conflict_error?
    (body.try(:[], :error) || []).find { |error| error.match?('уже зарегистрирован') }.present?
  end

  def failure?
    body.try(:[], :success).blank?
  end
end
