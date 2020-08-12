# frozen_string_literal: true

require "rails_helper"

require "lastfm"

RSpec.describe ArtistLookup do
  describe ".get_info" do
    it "returns information for an artist", :vcr do
      info = described_class.get_info("The Beatles")
      expect(info.name).to eq "The Beatles"
      expect(info.url).to eq "https://www.last.fm/music/The+Beatles"
      expect(info.image.default).to eq "https://lastfm.freetls.fastly.net/i/u/300x300/2a96cbd8b46e442fc41c2b86b821562f.png"
      expect(info.bio.content).to include("The Beatles were an English rock band formed in Liverpool in 1960")
    end

    it "handles symbols", :vcr do
      info = described_class.get_info("Bob Marley & The Wailers")
      expect(info.name).to eq "Bob Marley & The Wailers"
      expect(info.bio.content).not_to include("Incorrect tag")
    end

    it "corrects artist names", :vcr do
      info = described_class.get_info("Clash")
      expect(info.name).to eq "The Clash"
    end
  end
end
