# frozen_string_literal: true

require "rails_helper"

require "lastfm"

RSpec.describe AlbumLookup do
  describe ".search" do
    it "lists albums matching the search", :vcr do
      albums = described_class.search("The White Album")

      album = albums[1]
      expect(album.name).to eq "The Beatles (White Album)"
      expect(album.artist).to eq "The Beatles"
      expect(album.url).to eq "https://www.last.fm/music/The+Beatles/The+Beatles+(White+Album)"
    end
  end

  describe "#search" do
    subject(:album_lookup) { described_class.new(lastfm) }

    let(:lastfm) { instance_double(Lastfm, album: lastfm_album) }
    let(:lastfm_album) { instance_double(Lastfm::MethodCategory::Album, search: search_results) }

    let(:search_results) do
      {
        "results" => {
          "albummatches" => {
            "album" => [
              {
                "name" => "The Beatles (White Album)",
                "artist" => "The Beatles",
                "url" => "https://www.last.fm/music/The+Beatles/The+Beatles+(White+Album)",
                "image" => [{ "size" => "small", "content" => "https://lastfm.freetls.fastly.net/i/u/34s/210f365a483c4e1085a701764a9dcce9.png" }, { "size" => "medium", "content" => "https://lastfm.freetls.fastly.net/i/u/64s/210f365a483c4e1085a701764a9dcce9.png" }, { "size" => "large", "content" => "https://lastfm.freetls.fastly.net/i/u/174s/210f365a483c4e1085a701764a9dcce9.png" }, { "size" => "extralarge", "content" => "https://lastfm.freetls.fastly.net/i/u/300x300/210f365a483c4e1085a701764a9dcce9.png" }],
                "streamable" => "0",
                "mbid" => {}
              }
            ]
          }
        }
      }
    end

    it "calls lastfm.album.search" do
      album_lookup.search("The White Album")

      expect(lastfm_album).to have_received(:search).with("The White Album")
    end

    it "returns an array containing a representation of the album" do
      albums = album_lookup.search("The White Album")
      expect(albums.length).to eq 1

      album = albums[0]
      expect(album.name).to eq "The Beatles (White Album)"
      expect(album.artist).to eq "The Beatles"
      expect(album.url).to eq "https://www.last.fm/music/The+Beatles/The+Beatles+(White+Album)"
    end
  end
end
