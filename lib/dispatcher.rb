module Dispatcher
  extend ActiveSupport::Concern

  included do
    class_eval do
      def dispatch
        conn = Faraday.new do |builder|
          builder.request  :url_encoded
          builder.adapter  :net_http
        end

        block = Proc.new do |req|
          req.url(url)
          req.body = params
          req.headers['Content-Type'] = content_type || 'application/xml'
        end

        response = conn.send(method, &block)
        logger.info(response.body)

        return response
      end
    end
  end
end
