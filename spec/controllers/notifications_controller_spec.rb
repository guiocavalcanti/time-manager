require 'spec_helper'

describe NotificationsController do
  before do
    WebMock.allow_net_connect!
    stub_request(:any, "http://foo.bar")
  end

  let(:params) do
    { :url => "http://foo.bar", :method => "get", :params => "foo=bar&another=bar" }
  end

  it "should delay message delivery" do
    Delayed::Worker.delay_jobs = true
    expect {
      post :create, :notification => params
    }.to change(Delayed::Job, :count).by(1)
    Delayed::Worker.delay_jobs = false
  end
end

