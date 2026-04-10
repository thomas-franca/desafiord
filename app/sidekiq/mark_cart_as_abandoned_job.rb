class MarkCartAsAbandonedJob
  include Sidekiq::Job

  def perform(*_args)
    ManageAbandonedCartsJob.perform_now
  end
end
