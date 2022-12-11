class SendNotification
  ORDER_URL = 'account/orders'.freeze
  ORDER_MANAGE_URL = 'account/order_manages'.freeze
  ACCOUNT_PAPER = 'account/paper'.freeze
  ACCOUNT_VEHICLES = 'account/vehicles'.freeze
  PARTNER_URL = 'partner'.freeze

  def initialize(params)
    @params = params
  end

  attr_reader :params

  def call
    SendNotificationJob.perform_now(params)
  end

  def order_accept
    notification_param = {
      sender_id: params[:owner_id],
      receiver_id: params[:renter_id],
      on_click_url: "#{ORDER_URL}/#{params[:id]}",
      title: 'notification.title.order_accept',
      content: 'notification.content.order_accept'
    }

    SendNotificationJob.perform_now(notification_param)
  end

  def order_cancel
    notification_param = {
      sender_id: params[:owner_id],
      receiver_id: params[:renter_id],
      on_click_url: "#{ORDER_URL}/#{params[:id]}",
      title: 'notification.title.order_cancel',
      content: 'notification.content.order_cancel'
    }

    SendNotificationJob.perform_now(notification_param)
  end

  def order_create
    renter_params = {
      receiver_id: params[:renter_id],
      on_click_url: "#{ORDER_URL}/#{params[:id]}",
      title: 'notification.title.new_order_confirm',
      content: 'notification.content.new_order_confirm'
    }
    owner_params = {
      receiver_id: params[:owner_id],
      on_click_url: "#{ORDER_MANAGE_URL}/#{params[:id]}",
      title: 'notification.title.new_order',
      content: 'notification.content.new_order'
    }
    SendNotificationJob.perform_now(renter_params)
    SendNotificationJob.perform_now(owner_params)
  end

  def paper_confirm
    notification_param = {
      receiver_id: params[:id],
      on_click_url: ACCOUNT_PAPER,
      title: 'notification.title.paper_confirm',
      content: 'notification.content.paper_confirm'
    }

    SendNotificationJob.perform_now(notification_param)
  end

  def paper_reject
    notification_param = {
      receiver_id: params[:id],
      on_click_url: ACCOUNT_PAPER,
      title: 'notification.title.paper_reject',
      content: 'notification.content.paper_reject'
    }

    SendNotificationJob.perform_now(notification_param)
  end

  def partner_reject
    notification_param = {
      receiver_id: params[:id],
      on_click_url: PARTNER_URL,
      title: 'notification.title.partner_reject',
      content: 'notification.content.partner_reject'
    }

    SendNotificationJob.perform_now(notification_param)
  end

  def user_paid_order
    notification_params = {
      sender_id: params[:renter_id],
      receiver_id: params[:owner_id],
      on_click_url: "#{ORDER_MANAGE_URL}/#{params[:id]}",
      title: 'notification.title.paid_order',
      content: 'notification.content.paid_order'
    }
    SendNotificationJob.perform_now(notification_params)
  end
end
