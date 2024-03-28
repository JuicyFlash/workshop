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

    if @basket.nil?
      @basket = Basket.create(user_id: @user.id)
    end

    unless @session[:basket_id].nil?
      if @basket.id != @session[:basket_id]
        move_basket_items_from_to(@session[:basket_id], @basket.id)
        purge_basket(@session[:basket_id])
        @session[:basket_id] = nil
      end
    end
  end

  def move_basket_items_from_to(basket_id_from, basket_id_to)
    BasketProduct.where(basket_id: basket_id_from).update_all(basket_id: basket_id_to)
  end

  def purge_basket(purged_basket_id)
    Basket.delete(id = purged_basket_id)
  end

  def set_new_basket
    @basket = Basket.create
    @session[:basket_id] = @basket.id
  end
end
