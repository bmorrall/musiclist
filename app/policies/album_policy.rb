# frozen_string_literal: true

class AlbumPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end

  def refresh?
    user.admin?
  end

  def permitted_attributes
    super
  end

  # Safe scope for Album
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
