class Notification < ActiveRecord::Base
  include Dispatcher

  scope :sent_since, lambda { |date| where("sent_at > ?", date) }
end
