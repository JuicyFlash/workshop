class ApplicationController < ActionController::Base

  before_action :current_user

  def basket_service
    @basket_service ||= BasketService.new(session, current_user)
  end
end
