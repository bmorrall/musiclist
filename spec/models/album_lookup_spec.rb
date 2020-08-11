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

  describe ".get_info" do
    it "returns information for an album", :vcr do
      info = described_class.get_info(album: "The Beatles (White Album)", artist: "The Beatles")
      expect(info.name).to eq "The Beatles (White Album)"
      expect(info.artist).to eq "The Beatles"
      expect(info.url).to eq "https://www.last.fm/music/The+Beatles/The+Beatles+(White+Album)"
      expect(info.wiki.content).to include('The Beatles or “The White album” as it became better known was released on 22nd November, 1968')
      expect(info.tags.first).to eq "classic rock"
      expect(info.image.small).to eq "https://lastfm.freetls.fastly.net/i/u/34s/210f365a483c4e1085a701764a9dcce9.png"
      expect(info.image.default).to eq "https://lastfm.freetls.fastly.net/i/u/300x300/210f365a483c4e1085a701764a9dcce9.png"
      expect(info.image.extralarge).to eq "https://lastfm.freetls.fastly.net/i/u/300x300/210f365a483c4e1085a701764a9dcce9.png"
    end

    it "rejects the album year from tags", :vcr do
      info = described_class.get_info(album: "Pet Sounds", artist: "The Beach Boys")
      expect(info.tags.first).to eq "pop"
      expect(info.year).to eq "1966"
    end

    it "rejects the albums I own from genre ", :vcr do
      info = described_class.get_info(album: "Sea Change", artist: "Beck")
      expect(info.tags.first).to eq "acoustic"
      expect(info.year).to eq "2002"
    end

    it "removes any citations", :vcr do
      info = described_class.get_info(album: "Willy and the Poor Boys", artist: "Creedence Clearwater Revival")
      expect(info.wiki.content).not_to include("[2]")
    end

    it "separates the copyrighted content", :vcr do
      expected = <<~EXPECTED.strip
      Willy and the Poor Boys is the fourth album by American band Creedence Clearwater Revival, released in 1969. The only mention of the album's title is in the chorus of "Down on the Corner".

      In 2003, the album was ranked number 392 on Rolling Stone magazine's list of the 500 greatest albums of all time. A 40th Anniversary Edition CD with 3 bonus tracks was released in 2008. "Willy and the Poorboys" was the third CCR record to go platinum and went on to multi-platinum status. The cover photograph was shot a couple blocks from the Fantasy Records studio, in front of Duck Kee Market in West Oakland, California.

      <a href="http://www.last.fm/music/Creedence+Clearwater+Revival/Willy+and+the+Poor+Boys">Read more on Last.fm</a>. User-contributed text is available under the Creative Commons By-SA License; additional terms may apply.
      EXPECTED

      info = described_class.get_info(album: "Willy and the Poor Boys", artist: "Creedence Clearwater Revival")
      expect(info.wiki.content).to eq(expected)
    end

    it "handles artists without wiki entries", :vcr do
      info = described_class.get_info(album: "Call Me", artist: "Al Green")
      expect(info.wiki.content).to be_blank
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
