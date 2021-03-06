class BookPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all.order('updated_at DESC')
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def create_from_website?
    true
  end

  def update?
    user_owner?
  end

  def destroy?
    user.admin
  end

  private

  def user_owner?
    record.created_by == user
  end
end
