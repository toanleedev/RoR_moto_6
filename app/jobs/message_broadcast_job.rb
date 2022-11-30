class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast(
      "messages:#{message.receiver_id}",
      message: render_message(message),
      receiver: message.receiver
    )
  end

  private

  def render_message(message)
    current_user = message.receiver
    ApplicationController.renderer.render(partial: 'messages/message',
                                          locals: { message: message, current: current_user })
  end
end
