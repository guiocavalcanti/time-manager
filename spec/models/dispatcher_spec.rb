require "spec_helper"

describe Dispatcher do
  subject do
    class Foo
      include Dispatcher
      attr_accessor :url, :params, :body, :method, :content_type
      def initialize(attrs)
        attrs.each { |key, val| instance_variable_set(:"@#{key}", val) }
      end
    end

    Foo.new(:url => 'http://foo.bar/', :method => 'get',
            :params => 'foo=bar&another=bar')
  end

  it "should dispatch the request" do
    stub_request(:get, "http://foo.bar/").with(:body => subject.params)

    subject.dispatch
    WebMock.should have_requested(:get, "http://foo.bar").
      with(:body => "foo=bar&another=bar")
  end

  it "should dipatch the request with the correct method" do
    stub_request(:post, "http://foo.bar/").with(:body => subject.params)

    subject.method = 'post'
    subject.dispatch
    WebMock.should have_requested(:post, "http://foo.bar").
      with(:body => "foo=bar&another=bar")
  end

  it "should dispatch with the correct content type" do
    stub_request(:get, "http://foo.bar/").
      with(:body => "foo=bar&another=bar")

    subject.content_type = 'application/json'
    subject.dispatch
    WebMock.should have_requested(:get, 'http://foo.bar').
      with(:content_type => 'appalication/json')
  end
end
