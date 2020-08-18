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

  describe "audited" do
    it { should be_audited.only(%i[title year description]) }
  end

  describe "#slug" do
    let(:artist) { create(:artist, name: "Elton John") }

    it "replaces & with and" do
      album = described_class.new(
        title: "Captain Fantastic & The Brown Dirt Cowboy",
        artist: artist,
        lastfm_url: Faker::Internet.url
      )
      album.save
      expect(album.slug).to eq "captain-fantastic-and-the-brown-dirt-cowboy"
    end

    it "includes the artist name for Greatest Hits" do
      album = described_class.new(
        title: "Greatest Hits",
        artist: artist,
        lastfm_url: Faker::Internet.url
      )
      album.save
      expect(album.slug).to eq "elton-john-greatest-hits"
    end
  end
end
