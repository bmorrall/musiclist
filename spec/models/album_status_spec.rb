require "rails_helper"

RSpec.describe AlbumStatus, type: :model do
  # played_on:date
  it { is_expected.to have_db_column(:played_on) }
  # purchased:boolean
  it { is_expected.to have_db_column(:purchased) }
  # album:references
  it { is_expected.to have_db_column(:album_id) }
  it { is_expected.to belong_to(:album) }
end
