class AlbumStatusPolicy < ApplicationPolicy
  def update?
    user.admin?
  end
end
