class SetPlayedOnForAlbumStatuses < ActiveRecord::Migration[6.0]
  class AlbumStatus < ActiveRecord::Base; end

  def up
    ActiveRecord::Base.transaction do
      AlbumStatus.where(played: true).find_each do |status|
        status.update!(played_on: status.updated_at)
      end
    end
  end
end
