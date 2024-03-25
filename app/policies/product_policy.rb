class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
  def index?
    true
  end
  def put_in_basket?
    return false unless user.present?

    true
  end
  def put_out_basket?
    return false unless user.present?

    true
  end
  def purge_from_basket?
    return false unless user.present?

    true
  end
end
