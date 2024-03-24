class ApplicationController < ActionController::Base
  include Pundit

  before_action :current_user

  def basket_service
    @basket_service ||= BasketService.new(session, current_user)
  end
end
