class TodoPolicy < ApplicationPolicy
  def index?
     false
  end
  def show?
    user.present? && record.user == user
  end
end