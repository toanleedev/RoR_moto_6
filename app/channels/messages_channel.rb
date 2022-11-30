class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages:#{current_user.id}"
  end

  def unsubscribed
    stop_all_streams
  end
end
