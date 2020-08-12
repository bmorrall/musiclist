# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Artists", type: :request do
  describe "GET /artists" do
    context "with an authenticated admin" do
      let(:authenticated_admin) { create(:user, :admin) }

      before do
        sign_in(authenticated_admin)
      end

      it "renders a successful response" do
        artist = create(:artist)
        get artists_url
        expect(response).to be_successful
        expect(response.body).to have_link(href: artist_path(artist))
      end
    end

    context "with an authenticated user" do
      let(:authenticated_user) { create(:user) }

      before do
        sign_in(authenticated_user)
      end

      it "renders a successful response" do
        create(:artist)
        get artists_url
        expect(response).to be_successful
      end
    end

    context "with an unauthorized user" do
      let(:unauthorized_user) do
        skip("Provide a user where ArtistPolicy.index? is not granted")
      end

      before do
        sign_in(unauthorized_user)
      end

      it "forbids access" do
        create(:artist)
        get artists_url
        expect(response).to redirect_to(url_for_user_dashboard)

        follow_redirect!
        expect(response.body).to have_selector(".alert-error", text: t("pundit.example_policy.index?", default: t("pundit.default")))
      end
    end

    it "allows access to guests" do
      create(:artist)
      get artists_url
      expect(response).to be_successful
    end
  end

  describe "GET /artists/page/:page" do
    context "with an authenticated admin" do
      let(:authenticated_admin) { create(:user, :admin) }

      before do
        sign_in(authenticated_admin)
      end

      it "renders a successful response", :aggregate_failures do
        artist = create(:artist)
        get artists_url(page: 1)
        expect(response).to be_successful
        expect(response.body).to have_link(href: artist_path(artist))

        # Second Page
        get artists_url(page: 2)
        expect(response).to be_successful
        expect(response.body).not_to have_link(href: artist_path(artist))
      end
    end
  end

  describe "GET /artists/:id" do
    context "with an authenticated admin" do
      let(:authenticated_admin) { create(:user, :admin) }

      before do
        sign_in(authenticated_admin)
      end

      it "renders a successful response" do
        artist = create(:artist)
        get artist_url(artist)
        expect(response).to be_successful
      end
    end

    context "with an authenticated user" do
      let(:authenticated_user) { create(:user) }

      before do
        sign_in(authenticated_user)
      end

      it "renders a successful response" do
        artist = create(:artist)
        get artist_url(artist)
        expect(response).to be_successful
      end

      it "renders any albums belonging to the artist" do
        artist = create(:artist)
        album = create(:album, artist: artist);
        get artist_url(artist)
        expect(response).to be_successful
        expect(response.body).to have_content(album.title)
      end
    end

    context "with an unauthorized user" do
      let(:unauthorized_user) do
        skip("Provide a user where ArtistPolicy.show? is not granted")
      end

      before do
        sign_in(unauthorized_user)
      end

      it "forbids access" do
        artist = create(:artist)
        get artist_url(artist)
        expect(response).to redirect_to(artists_url)

        follow_redirect!
        expect(response.body).to have_selector(".alert-error", text: t("pundit.example_policy.show?", default: t("pundit.default")))
      end
    end

    it "allows access to guests" do
      artist = create(:artist)
      get artist_url(artist)
      expect(response).to be_successful
    end
  end

  describe "GET /artists/:id/edit" do
    context "with an authenticated admin" do
      let(:authenticated_admin) { create(:user, :admin) }

      before do
        sign_in(authenticated_admin)
      end

      it "render a successful response" do
        artist = create(:artist)
        get edit_artist_url(artist)
        expect(response).to be_successful
      end
    end

    context "with an authenticated user" do
      let(:authenticated_user) { create(:user) }

      before do
        sign_in(authenticated_user)
      end

      it "forbids access" do
        artist = create(:artist)
        get edit_artist_url(artist)
        expect(response).to redirect_to(artist_url(artist))

        follow_redirect!
        expect(response.body).to have_selector(".alert-error", text: t("pundit.example_policy.edit?", default: t("pundit.default")))
      end
    end

    it "does not allow access to guests" do
      artist = create(:artist)
      get edit_artist_url(artist)
      expect(response).to redirect_to(url_for_authentication)
    end
  end

  describe "PATCH /artists/:id" do
    context "with valid parameters" do
      let(:new_attributes) do
        attributes_for(:artist).slice(:name)
      end

      context "with an authenticated admin" do
        let(:authenticated_admin) { create(:user, :admin) }

        before do
          sign_in(authenticated_admin)
        end

        it "updates the requested artist" do
          artist = create(:artist)
          patch artist_url(artist), params: { artist: new_attributes }

          artist.reload
          expect(artist.name).to eq(new_attributes[:name])
        end

        it "audits the change", :aggregate_failures do
          artist = create(:artist)

          expect do
            patch artist_url(artist), params: { artist: new_attributes }
          end.to change(Audit, :count).by(1)

          audit = artist.audits.last!
          expect(audit.action).to eq "update"
          expect(audit.associated).to be_nil
          expect(audit.user_uid).to eq authenticated_admin.id
          expect(audit.remote_address).not_to eq request.remote_ip # Anonymized
          expect(audit.request_uuid).to eq request.request_id
        end

        it "redirects to the artist" do
          artist = create(:artist)
          patch artist_url(artist), params: { artist: new_attributes }
          artist.reload
          expect(response).to redirect_to(artist_url(artist))
        end
      end

      context "with an authenticated user" do
        let(:authenticated_user) { create(:user) }

        before do
          sign_in(authenticated_user)
        end

        it "forbids access" do
          artist = create(:artist)
          patch artist_url(artist), params: { artist: new_attributes }
          expect(response).to redirect_to(artist_url(artist))

          follow_redirect!
          expect(response.body).to have_selector(".alert-error", text: t("pundit.example_policy.update?", default: t("pundit.default")))
        end
      end

      it "does not allow access to guests" do
        artist = create(:artist)
        patch artist_url(artist), params: { artist: new_attributes }
        expect(response).to redirect_to(url_for_authentication)
      end
    end

    context "with invalid parameters" do
      let(:authenticated_admin) { create(:user, :admin) }

      let(:invalid_attributes) do
        skip("Add a hash of attributes invalid for your model")
      end

      before do
        sign_in(authenticated_admin)
      end

      it "renders a successful response (i.e. to display the 'edit' template)" do
        artist = create(:artist)
        patch artist_url(artist), params: { artist: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /artists/:id" do
    context "with an authenticated admin" do
      let(:authenticated_admin) { create(:user, :admin) }

      before do
        sign_in(authenticated_admin)
      end

      it "destroys the requested artist" do
        artist = create(:artist)
        expect do
          delete artist_url(artist)
        end.to change(Artist, :count).by(-1)
      end

      it "audits the change", :aggregate_failures do
        artist = create(:artist)

        expect do
          delete artist_url(artist)
        end.to change(Audit, :count).by(1)

        audit = Audit.last!
        expect(audit.action).to eq "destroy"
        expect(audit.auditable_id).to eq artist.id
        expect(audit.associated).to be_nil
        expect(audit.user_uid).to eq authenticated_admin.id
        expect(audit.remote_address).not_to eq request.remote_ip # Anonymized
        expect(audit.request_uuid).to eq request.request_id
      end

      it "redirects to the artists list" do
        artist = create(:artist)
        delete artist_url(artist)
        expect(response).to redirect_to(artists_url)
      end

      it "forbids access for artists with at least one album" do
        artist = create(:album).artist

        delete artist_url(artist)
        expect(response).to redirect_to(artist_url(artist))

        follow_redirect!
        expect(response.body).to have_selector(".alert-error", text: t("pundit.example_policy.destroy?", default: t("pundit.default")))
      end
    end

    context "with an authenticated user" do
      let(:authenticated_user) { create(:user) }

      before do
        sign_in(authenticated_user)
      end

      it "forbids access" do
        artist = create(:artist)
        delete artist_url(artist)
        expect(response).to redirect_to(artist_url(artist))

        follow_redirect!
        expect(response.body).to have_selector(".alert-error", text: t("pundit.example_policy.destroy?", default: t("pundit.default")))
      end
    end

    it "does not allow access to guests" do
      artist = create(:artist)
      delete artist_url(artist)
      expect(response).to redirect_to(url_for_authentication)
    end
  end
end
