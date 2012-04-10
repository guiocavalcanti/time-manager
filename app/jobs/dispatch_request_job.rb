class DispatchRequestJob
  attr_accessor :notification_id

  def initialize(notification_id)
    @notification_id = notification_id
  end

  def perform
    begin
      notification.dispatch
    rescue ActiveRecord::RecordNotFound
    ensure
      reenqueue if notification.reaload
    end
  end

  def display_name

  end

  protected

  def notification
    @notifiction ||= Notification.find(@notification_id)
  end

  def reenqueue(notification)
    Delayed::Job.enqueue(DispatchRequestJob.new(@notification_id),
                         :run_at => notification.periodicity_time.seconds.from_now)
  end

end
