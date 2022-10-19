# frozen_string_literal: true

class ServiceResult
  attr_reader :success, :data, :errors, :error_keys

  def initialize(success:, data: nil, errors: [], error_keys: [])
    raise ArgumentError, 'success must be true or false' unless success.in? [true, false]

    @success = success
    @data = data
    @errors = errors
    @error_keys = error_keys
  end

  def success?
    success
  end

  def failure?
    !success?
  end

  def data?
    data.present?
  end

  def errors?
    errors.present?
  end

  def error_messages
    errors.map(&:to_s)
  end
end
