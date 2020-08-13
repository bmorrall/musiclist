# frozen_string_literal: true

require "rails_helper"

RSpec.describe PopulateArtists do
  describe ".call" do
    {
      "Gang Of Four" => "Gang of Four",
      "Pj Harvey" => "PJ Harvey",
      "Rage Against The Machine" => "Rage Against the Machine",
      "Toots & Maytals" => "Toots and The Maytals"
    }.each do |original, correction|
      it "renames \"#{original}\" to \"#{correction}\"", :vcr do
        artist = create(:artist, name: original, lastfm_url: nil)
        expect do
          described_class.call
          artist.reload
        end.to change(artist, :name).to correction
      end
    end
  end
end
