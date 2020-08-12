# frozen_string_literal: true

class ArtistPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def refresh?
    user.admin?
  end

  def destroy?
    user.admin? && record.albums.none?
  end

  def permitted_attributes
    user.admin? ? %i[name description] : super
  end

  # Safe scope for Artist
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
