class SupportRequestsController < ApplicationController
  def index 
    @support_requests = SupportRequest.all
    #byebug
  end

  def update
    #byebug
    support_request = SupportRequest.find(params[:id])
    support_request.update(response: 
                          params[:support_request][:response])
    SupportRequestMailer.respond(support_request).deliver_now
    redirect_to support_requests_path
  end
end