require "rails_helper"

RSpec.describe Artist, type: :model do
  it { is_expected.to have_many(:albums) }

  it { is_expected.to have_db_column(:name) }
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to have_db_column(:lastfm_url) }

  it { is_expected.to have_db_column(:profile_image) }

  it { is_expected.to have_db_column(:description) }

  describe "#slug" do
    it "replaces & with and" do
      artist = described_class.new(name: "Bob Marley & The Wailers")
      artist.save
      expect(artist.slug).to eq "bob-marley-and-the-wailers"
    end
  end
end
