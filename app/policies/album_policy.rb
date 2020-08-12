# frozen_string_literal: true

# Policy for Albums.
# Allows Admins to Update or override details using Last.fm
# Full read access to all guests and users
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
    user.admin?
  end

  def destroy?
    false
  end

  def refresh?
    user.admin?
  end

  def permitted_attributes
    user.admin? ? %i[artist_id title year genre description] : super
  end

  # Safe scope for Album
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
