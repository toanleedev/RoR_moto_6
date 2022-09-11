# frozen_string_literal: true

class BaseFilter
  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 20

  attr_reader :page, :per_page

  def initialize(options = {}, current_user)
    @page = [options[:page].to_i, DEFAULT_PAGE].find(&:positive?)
    @per_page = [options[:per_page].to_i, DEFAULT_PER_PAGE].find(&:positive?)
  end
end
