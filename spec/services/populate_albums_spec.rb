# frozen_string_literal: true

require "rails_helper"

RSpec.describe PopulateAlbums do
  describe ".call" do
    {
      ["Low End Theory", "A Tribe Called Quest"] => "The Low End Theory"
    }.each do |(original, artist_name), correction|
      it "renames \"#{original}\" to \"#{correction}\"", :vcr do
        artist = create(:artist, name: artist_name)
        album = create(:album, title: original, artist: artist, lastfm_url: nil)
        expect do
          described_class.call
          album.reload
        end.to change(album, :title).to correction
      end
    end
  end
end
