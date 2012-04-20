require 'spec_helper'

describe Notification do
  subject do
    Notification.create(:url => 'http://foo.bar')
  end

  context "defaults" do
    it "method should default to get" do
      subject.method.should == 'get'
    end

    it "content_type should default to application/xml" do
      subject.content_type.should == 'application/xml'
    end
  end

  context "scope" do
    it "should return notification sent after a date" do
      3.times do
        Notification.create(:url => 'http://foo.bar', :sent_at => DateTime.now)
      end
      Notification.first.update_attribute(:sent_at, 2.years.ago)

      Notification.sent_since(1.minute.ago).count.should == 2
    end
  end
end
