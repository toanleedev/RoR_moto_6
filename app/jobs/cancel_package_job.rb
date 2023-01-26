class CancelPackageJob < ApplicationJob
  queue_as :default
  def perform(priority)
    return unless priority.online?

    priority.status = :offline
    priority.save!
  end
end
