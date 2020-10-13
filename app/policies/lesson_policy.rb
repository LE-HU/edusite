class LessonPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    @record.course.user_id == @user.id || @user.has_role?(:admin)
  end

  def edit?
    @record.course.user_id == @user.id
  end

  def update?
    @record.course.user_id == @user.id
  end

  def new?
  end

  def create?
  end

  def destroy?
    @record.course.user_id == @user.id
  end
end
