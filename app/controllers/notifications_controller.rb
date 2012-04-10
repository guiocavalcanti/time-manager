class NotificationsController < ApplicationController
  respond_to :xml, :json

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
