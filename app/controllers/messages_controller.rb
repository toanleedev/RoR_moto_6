class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_rooms, only: %i[index show]

  def index; end

  def show
    @receiver = User.find_by(id: params[:id])

    return redirect_to messages_path, flash: { alert: t('.user_not_found') } unless @receiver.present?

    @message = Message.new
    @room_messages =
      Message.where(sender_id: [current_user, @receiver], receiver_id: [current_user, @receiver])
  end

  def create
    message = Message.new message_params
    if message.save
      MessageBroadcastJob.perform_now(message)
    else
      flash[:alert] = t('.create_failure')
    end
    redirect_to message_path(message.receiver)
  end

  private

  def set_user_rooms
    @rooms = current_user.message_rooms
  end

  def message_params
    params.require(:message).permit(:content, :receiver_id).to_h.deep_merge(
      sender_id: current_user.id
    )
  end
end
