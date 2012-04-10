class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from ActiveRecord::RecordNotFound, :with => :not_found
  rescue_from MultiJson::DecodeError, :with => :decode_error

  def not_found
    respond_with(nil, :status => :not_found)
  end

  def decode_error
    respond_with({:error => 'decode error'}, :status => 500)
  end
end
