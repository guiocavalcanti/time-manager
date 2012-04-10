require "spec_helper"

describe "Notification" do
  before do
    @params = { :url => "http://foo.bar", :method => "get",
               :params => "foo=bar&another=bar" }
    post "/notifications.json", :notification => @params
  end

  context "when creating" do
    it "should return status 200" do
      response.code.should == "201"
    end

    it "should return the entity" do
      doc = ActiveSupport::JSON.decode(response.body)
      %w(id created_at params method url).each do |attr|
        doc.should have_key(attr)
      end
    end
  end

  context "when deleting" do
    before do
      @params = { :url => "http://foo.bar", :method => "get",
                  :params => "foo=bar&another=bar" }
      post "/notifications.json", @params
      @entity = ActiveSupport::JSON.decode(response.body)
    end

    it "should return status 204" do
      delete "/notifications/#{@entity['id']}", :format => 'json'
      response.code.should == '204'
    end

    it "should really delete" do
      delete "/notifications/#{@entity['id']}", :format => 'json'
      get "/notifications/#{@entity['id']}", :format => 'json'
      response.code.should == '404'
    end
  end
end
