require "rails_helper"

RSpec.describe AlbumStatus, type: :model do
  # played:boolean
  it { is_expected.to have_db_column(:played) }
  # purchased:boolean
  it { is_expected.to have_db_column(:purchased) }
  # album:references
  it { is_expected.to have_db_column(:album) }

  describe "audited" do
    it { should be_audited.only(%i[played purchased album_id]) }
    # it { should be_audited.associated_with(:album) }
  end
end
