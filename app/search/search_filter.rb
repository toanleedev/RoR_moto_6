# frozen_string_literal: true

class SearchFilter
  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 10

  def initialize(options = {})
    @page = [options[:page].to_i, DEFAULT_PAGE].find(&:positive?)
    @per_page = [options[:per_page].to_i, DEFAULT_PER_PAGE].find(&:positive?)

    @name = options[:name].presence
    @province = options[:province].presence
    @brand = options[:brand].presence
    @type = options[:type].presence
    @engine = options[:engine].presence
    @start_date = options[:start_date].presence
  end

  def filter
    records = Vehicle.includes(:brand, :type, :engine, :vehicle_images, :ratings,
                               :priorities, user: [:address])
                     .where(status: %i[idle rented])
                     .order('priorities.rank desc NULLS LAST, priorities.updated_at')
    if @province.present?
      records =
        records.joins(user: [:address]).where('addresses.province LIKE ?', "%#{@province}%")
    end
    if @name.present? # a long comment that makes it too long
      records = records.where('name ILIKE ?', "%#{@name}%")
    end

    if @brand.present? # a long comment that makes it too long
      records = records.where(brand_id: @brand)
    end

    if @type.present? # a long comment that makes it too long
      records = records.where(type_id: @type)
    end

    if @engine.present? # a long comment that makes it too long
      records = records.where(engine_id: @engine)
    end

    records.page(@page).per(@per_page)
  end
end
