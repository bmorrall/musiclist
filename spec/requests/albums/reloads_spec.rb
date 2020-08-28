require "rails_helper"

RSpec.describe "Albums::Reload", type: :request do
  describe "POST /albums/1/reload" do
    context "with an authenticated admin" do
      let(:authenticated_admin) { create(:user, :admin) }

      before do
        sign_in(authenticated_admin)
      end

      context "with a known album", :vcr do
        let(:artist) { create(:artist, name: "The Beatles") }
        let(:album) { create(:album, artist: artist, title: "White Album", description: nil) }

        it "populates the album details", :aggregate_failures do
          post album_reload_url(album)

          album.reload
          expect(album.title).to eq "White Album"
          expect(album.lastfm_url).to eq "https://www.last.fm/music/The+Beatles/White+Album"
          expect(album.description).not_to be_blank
        end

        it "redirects back to the album" do
          post album_reload_url(album)
          expect(response).to redirect_to(album_url(album.reload))
        end
      end
    end
  end
end
