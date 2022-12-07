class TestJob < ApplicationJob
  queue_as :default
  def perform id
    Message.find(id).destroy
  end
end
