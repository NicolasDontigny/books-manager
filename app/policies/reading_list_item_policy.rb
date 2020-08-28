class ReadingListItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user).order(:priority)
    end
  end

  def read_books?
    true
  end

  def create?
    true
  end

  def update?
    user_owner?
  end

  def destroy?
    user_owner?
  end

  def mark_as_read?
    user_owner?
  end

  def mark_as_unread?
    user_owner?
  end

  private

  def user_owner?
    record.user == user
  end
end
