require "rails_helper"

RSpec.describe Album, type: :model do
  it { is_expected.to have_db_column(:title) }
  it { is_expected.to validate_presence_of(:title) }

  it { is_expected.to have_db_column(:artist_id) }
  it { is_expected.to validate_presence_of(:artist_id) }

  it { is_expected.to have_db_column(:genre) }
  it { is_expected.to have_db_column(:album_art) }

  it { is_expected.to have_db_column(:year) }
  it { is_expected.to allow_value("1985").for(:year) }
  it { is_expected.to allow_value("2020").for(:year) }
  it { is_expected.not_to allow_value("99").for(:year) }
  it { is_expected.to allow_value(nil).for(:year) }

  it { is_expected.to have_db_column(:editions) }

  describe "audited" do
    it { should be_audited.only(%i[title year description]) }
  end
end
