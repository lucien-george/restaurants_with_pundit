class RestaurantPolicy < ApplicationPolicy # inherits from ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all # => Restaurant.all
    end
  end

  def create?
    user
  end

  def show?
    true
  end

  def edit?
    # 1. user => current_user
    # 2. record => argument passed to authorize method (@restaurant in our case)
    user_is_owner?
  end

  def update?
    user_is_owner?
  end

  def destroy?
    user_is_owner?
  end

  private

  def user_is_owner?
    user == record.user || user.admin
  end
end
