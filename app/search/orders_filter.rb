# frozen_string_literal: true

class OrdersFilter < BaseFilter
  def initialize(options = {}, current_user)
    super

    @status = options[:status].presence
    @uid = options[:uid].presence
    @current_user = current_user
  end

  attr_reader :status, :uid

  def filter
    records = @current_user.orders.includes(:vehicle, vehicle: [:vehicle_images])

    if status.present?
      case status
      when 'coming'
        records = records.where.not(status: %i[completed canceled])
      when 'completed'
        records = records.where(status: :completed)
      when 'canceled'
        records = records.where(status: :canceled)
      end
    end

    records = records.where(uid: uid) if uid.present?

    records.order(created_at: :desc).page(@page).per(@per_page)
  end

  def filter_rental
    records = @current_user.rental_orders.includes(:vehicle, vehicle: [:vehicle_images])

    records = records.where(status: status) if status.present?
    records = records.where(uid: uid) if uid.present?
    records.order(created_at: :desc).page(@page).per(@per_page)
  end
end
