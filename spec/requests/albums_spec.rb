# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Albums", type: :request do
  describe "GET /albums" do
    context "with an authenticated admin" do
      let(:authenticated_admin) { create(:user, :admin) }

      before do
        sign_in(authenticated_admin)
      end

      it "renders a successful response" do
        album = create(:album)
        get albums_url
        expect(response).to be_successful
        expect(response.body).to have_link(href: album_path(album))
      end

      it "renders multiple albums" do
        create(:album_status, purchased: true, played: true)
        create(:album_status, purchased: false, played: false)

        get albums_url
        expect(response).to be_successful
      end
    end

    context "with an authenticated user" do
      let(:authenticated_user) { create(:user) }

      before do
        sign_in(authenticated_user)
      end

      it "renders a successful response" do
        create(:album)
        get albums_url
        expect(response).to be_successful
      end
    end

    context "with an unauthorized user" do
      let(:unauthorized_user) do
        skip("Provide a user where AlbumPolicy.index? is not granted")
      end

      before do
        sign_in(unauthorized_user)
      end

      it "forbids access" do
        create(:album)
        get albums_url
        expect(response).to redirect_to(url_for_user_dashboard)

        follow_redirect!
        expect(response.body).to have_selector(".alert-error", text: t("pundit.example_policy.index?", default: t("pundit.default")))
      end
    end

    it "does not allow access to guests" do
      create(:album)
      get albums_url
      expect(response).to redirect_to(url_for_authentication)
    end
  end

  describe "GET /albums/:id" do
    context "with an authenticated admin" do
      let(:authenticated_admin) { create(:user, :admin) }

      before do
        sign_in(authenticated_admin)
      end

      it "renders a successful response" do
        album = create(:album)
        get album_url(album)
        expect(response).to be_successful
      end

      it "renders played and purchased albums" do
        album_status = create(:album_status, purchased: true, played: true)
        album = album_status.album
        get album_url(album)
        expect(response).to be_successful
      end

      it "renders unplayed and unpurchased albums" do
        album_status = create(:album_status, purchased: false, played: false)
        album = album_status.album
        get album_url(album)
        expect(response).to be_successful
      end
    end

    context "with an authenticated user" do
      let(:authenticated_user) { create(:user) }

      before do
        sign_in(authenticated_user)
      end

      it "renders a successful response" do
        album = create(:album)
        get album_url(album)
        expect(response).to be_successful
      end
    end

    context "with an unauthorized user" do
      let(:unauthorized_user) do
        skip("Provide a user where AlbumPolicy.show? is not granted")
      end

      before do
        sign_in(unauthorized_user)
      end

      it "forbids access" do
        album = create(:album)
        get album_url(album)
        expect(response).to redirect_to(albums_url)

        follow_redirect!
        expect(response.body).to have_selector(".alert-error", text: t("pundit.example_policy.show?", default: t("pundit.default")))
      end
    end

    it "does not allow access to guests" do
      album = create(:album)
      get album_url(album)
      expect(response).to redirect_to(url_for_authentication)
    end
  end

  describe "GET /albums/:id/edit" do
    context "with an authenticated admin" do
      let(:authenticated_admin) { create(:user, :admin) }

      before do
        sign_in(authenticated_admin)
      end

      it "render a successful response" do
        album = create(:album)
        get edit_album_url(album)
        expect(response).to be_successful
      end
    end

    context "with an authenticated user" do
      let(:authenticated_user) { create(:user) }

      before do
        sign_in(authenticated_user)
      end

      it "forbids access" do
        album = create(:album)
        get edit_album_url(album)
        expect(response).to redirect_to(album_url(album))

        follow_redirect!
        expect(response.body).to have_selector(".alert-error", text: t("pundit.example_policy.edit?", default: t("pundit.default")))
      end
    end

    it "does not allow access to guests" do
      album = create(:album)
      get edit_album_url(album)
      expect(response).to redirect_to(url_for_authentication)
    end
  end

  describe "PATCH /albums/:id" do
    context "with valid parameters" do
      let(:new_attributes) do
        attributes_for(:album).slice(:title, :year, :genre, :description)
      end

      context "with an authenticated admin" do
        let(:authenticated_admin) { create(:user, :admin) }

        before do
          sign_in(authenticated_admin)
        end

        it "updates the requested album" do
          album = create(:album)
          patch album_url(album), params: { album: new_attributes }

          album.reload
          expect(album.title).to eq(new_attributes[:title])
          expect(album.year).to eq(new_attributes[:year])
          expect(album.genre).to eq(new_attributes[:genre])
          expect(album.description).to eq(new_attributes[:description])
        end

        it "audits the change", :aggregate_failures do
          album = create(:album)

          expect do
            patch album_url(album), params: { album: new_attributes }
          end.to change(Audit, :count).by(1)

          audit = album.audits.last!
          expect(audit.action).to eq "update"
          expect(audit.associated).to be_nil
          expect(audit.user_uid).to eq authenticated_admin.id
          expect(audit.remote_address).not_to eq request.remote_ip # Anonymized
          expect(audit.request_uuid).to eq request.request_id
        end

        it "redirects to the album" do
          album = create(:album)
          patch album_url(album), params: { album: new_attributes }
          album.reload
          expect(response).to redirect_to(album_url(album))
        end
      end

      context "with an authenticated user" do
        let(:authenticated_user) { create(:user) }

        before do
          sign_in(authenticated_user)
        end

        it "forbids access" do
          album = create(:album)
          patch album_url(album), params: { album: new_attributes }
          expect(response).to redirect_to(album_url(album))

          follow_redirect!
          expect(response.body).to have_selector(".alert-error", text: t("pundit.example_policy.update?", default: t("pundit.default")))
        end
      end

      it "does not allow access to guests" do
        album = create(:album)
        patch album_url(album), params: { album: new_attributes }
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
        album = create(:album)
        patch album_url(album), params: { album: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end
end
