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

  context "periodicity_time" do
    context "daily" do
      it "should return day as seconds" do
        subject.periodicity_time.should == 60*60*24
      end
    end

    context "minutely" do
      subject do
        Notification.create(:url => 'http://foo.bar', :periodicity => 'minutely' )
      end

      it "should return minute as seconds" do
        subject.periodicity_time.should == 60
      end
    end

    context "hourly" do
      subject do
        Notification.create(:url => 'http://foo.bar', :periodicity => 'hourly' )
      end

      it "should return minute as seconds" do
        subject.periodicity_time.should == 60*60
      end
    end

  end
end
