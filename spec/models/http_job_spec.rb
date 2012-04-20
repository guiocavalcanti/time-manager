require 'spec_helper'

describe HttpJob::PerformRequest do
  subject {  HttpJob::PerformRequest.new(69) }
  let(:failed_response) do
    double('WebMock::Response', :"success?" => false)
  end
  let(:success_response) do
    double('WebMock::Response', :"success?" => true)
  end

  it "should reenqueue when response code isnt 200..299" do
    notification = double("Notification", :dispatch => failed_response)
    subject.stub(:notification).and_return(notification)
    subject.stub(:"exceeded_rate?").and_return(false)

    expect { subject.perform }.to raise_error(HttpJob::RequestFailed)
  end

  it "should respect the rate limit" do
    notification = double("Notification", :dispatch => success_response)
    subject.stub(:notification).and_return(notification)
    subject.stub(:"exceeded_rate?").and_return(true)

    expect { subject.perform }.to raise_error(HttpJob::RateLimitExceeded)
  end

  it "should set sent_at attribute on notification" do
    notification = double("Notification", :dispatch => success_response)
    subject.stub(:notification).and_return(notification)
    subject.stub(:"exceeded_rate?").and_return(false)

    notification.should_receive(:touch).with(:sent_at)
    subject.perform
  end
end
