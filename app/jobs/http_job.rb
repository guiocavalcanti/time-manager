module HttpJob
  RATE = 60

  class RequestFailed < Exception; end
  class RateLimitExceeded < Exception; end

  class PerformRequest
    attr_accessor :notification_id

    def initialize(notification_id)
      @notification_id = notification_id
    end

    def perform
      if notification
        raise RateLimitExceeded if exceeded_rate?

        if notification.dispatch.success?
          notification.touch(:sent_at)
        else
          raise RequestFailed
        end
      end
    end

    def exceeded_rate?
      Notification.sent_since(DateTime.now).count > HttpJob::RATE
    end

    def notification
      @notification ||= Notification.find_by_id(@notification_id)
    end
  end
end
