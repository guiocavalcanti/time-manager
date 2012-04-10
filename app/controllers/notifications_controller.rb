class NotificationsController < ApplicationController
  wrap_parameters :format => [:json, :xml, :url_encoded_form]
  respond_to :xml, :json, :url_encoded_form

  def create
    @notification = Notification.create(params[:notification])

    if @notification.valid?
      Delayed::Job.enqueue(DispatchRequestJob.new(@notification.id))
    end

    respond_with @notification
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy

    respond_with(@notification)
  end

  def show
    @notification = Notification.find(params[:id])
    respond_with(@notification)
  end
end
