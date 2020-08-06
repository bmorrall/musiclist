require "rails_helper"

RSpec.describe "Albums::Refresh", type: :request do
  let(:artist) { create(:artist, name: "The Beatles") }
  let(:album) { create(:album, title: "The White Album", artist: artist) }

  describe "GET /show" do
    context "with an authenticated admin" do
      let(:authenticated_admin) { create(:user, :admin) }

      before do
        sign_in(authenticated_admin)
      end

      context "with a known album", :vcr do
        it "renders a successful response" do
          get album_refresh_url(album)
          expect(response).to be_successful
        end
      end
    end
  end

  describe "POST /create" do
    context "with valid parameters", :vcr do
      let(:artist) { create(:artist, name: "The Beatles") }
      let(:album) { create(:album, title: "The White Album", artist: artist) }
      let(:valid_attributes) do
        {
          album: "The Beatles (White Album)",
          artist: "The Beatles"
        }
      end

      context "with an authenticated admin" do
        let(:authenticated_admin) { create(:user, :admin) }

        before do
          sign_in(authenticated_admin)
        end

        it "populates the album details" do
          post album_refresh_url(album), params: { lookup: valid_attributes }

          album.reload
          expect(album.title).to eq "The Beatles (White Album)"
          expect(album.genre).to eq "classic rock"
          expect(album.year).to be_blank
          expect(album.description).to include('The Beatles or “The White album” as it became better known was released on 22nd November, 1968')
        end

        it "redirects to the album" do
          post album_refresh_url(album), params: { lookup: valid_attributes }
          expect(response).to redirect_to(album_url(album))
        end
      end

      it "does not allow non-admin access" do
        sign_in create(:user)

        post album_refresh_url(album), params: { lookup: valid_attributes }
        expect(response).to redirect_to(album_url(album))

        follow_redirect!
        expect(response.body).to have_content(t("pundit.default"))
      end
    end
  end
end
