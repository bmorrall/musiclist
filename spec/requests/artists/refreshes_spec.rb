require "rails_helper"

RSpec.describe "Artists::Reload", type: :request do
  describe "POST /artists/1/reload" do
    context "with an authenticated admin" do
      let(:authenticated_admin) { create(:user, :admin) }

      before do
        sign_in(authenticated_admin)
      end

      context "with a known artist", :vcr do
        let(:artist) { create(:artist, name: "Beatles") }

        it "populates the artist details", :aggregate_failures  do
          post artist_reload_url(artist)

          artist.reload
          expect(artist.name).to eq "The Beatles"
          expect(artist.profile_image).to eq "https://lastfm.freetls.fastly.net/i/u/300x300/2a96cbd8b46e442fc41c2b86b821562f.png"
          expect(artist.lastfm_url).to eq "https://www.last.fm/music/The+Beatles"
          expect(artist.description).to include('The Beatles were an English rock band formed in Liverpool in 1960')
        end

        it "redirects back to the artist" do
          post artist_reload_url(artist)
          expect(response).to redirect_to(artist_url(artist))
        end
      end
    end
  end
end
