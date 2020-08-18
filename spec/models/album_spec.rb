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
      expect(album.slug).to eq "elton-john-captain-fantastic-and-the-brown-dirt-cowboy"
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

    it "includes the artist name for Live" do
      album = described_class.new(
        title: "Live 1984",
        artist: artist,
        lastfm_url: Faker::Internet.url
      )
      album.save
      expect(album.slug).to eq "elton-john-live-1984"
    end

    it "does not include the artist name if already present" do
      album = described_class.new(
        title: "Live with Elton John",
        artist: artist,
        lastfm_url: Faker::Internet.url
      )
      album.save
      expect(album.slug).to eq "live-with-elton-john"
    end

    it "handles abbreviations" do
      album = described_class.new(
        title: "Superfly - O.S.T.",
        artist: artist,
        lastfm_url: Faker::Internet.url
      )
      album.save
      expect(album.slug).to eq "elton-john-superfly-ost"
    end

    it "handles names starting with the" do
      artist.name = "The Clash"
      album = described_class.new(
        title: "Clash: UK Edition.",
        artist: artist,
        lastfm_url: Faker::Internet.url
      )
      album.save
      expect(album.slug).to eq "clash-uk-edition"
    end

    it "ignores the 'Various Artists' artist" do
      artist.name = "Various Artists"
      album = described_class.new(
        title: "Nuggets: Original Artyfacts from the First Psychedelic Era, 1965-1968",
        artist: artist,
        lastfm_url: Faker::Internet.url
      )
      album.save
      expect(album.slug).to eq "nuggets-original-artyfacts-from-the-first-psychedelic-era-1965-1968"
    end
  end
end
