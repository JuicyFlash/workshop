class BasketService

  attr_reader :basket

  def initialize(session, user)
    @session = session
    @user = user
    prepare_basket
  end

  def prepare_basket
    if @user.nil?
      prepare_basket_by_session
    else
      prepare_basket_by_user
    end
  end

  private

  def prepare_basket_by_session
    if @session[:basket_id].nil? ||  Basket.find_by(id: @session[:basket_id]).nil?
      set_new_basket
    else
      @basket = Basket.find_by(id: @session[:basket_id])
    end
  end

  def prepare_basket_by_user
    @basket = @user.basket

    @basket = Basket.create(user_id: @user.id) if @basket.nil?

    if @session[:basket_id].present? && @session[:basket_id] != @basket.id
      @basket.copy_basket_products_from(@session[:basket_id])
      purge_basket(@session[:basket_id])
      @session[:basket_id] = nil
    end
  end

  def purge_basket(purged_basket_id)
    Basket.destroy(id = purged_basket_id)
  end

  def set_new_basket
    @basket = Basket.create
    @session[:basket_id] = @basket.id
  end
end
