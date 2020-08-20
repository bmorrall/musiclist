# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Albums::Years", type: :request do
  describe "GET /albums/years" do
    context "with an authenticated admin" do
      let(:authenticated_admin) { create(:user, :admin) }

      before do
        sign_in(authenticated_admin)
      end

      it "renders a successful response" do
        year = create(:album).year
        get albums_years_url
        expect(response).to be_successful
        expect(response.body).to have_link(href: albums_year_path(year))
      end
    end

    context "with an authenticated user" do
      let(:authenticated_user) { create(:user) }

      before do
        sign_in(authenticated_user)
      end

      it "renders a successful response" do
        year = create(:album).year
        get albums_years_url
        expect(response).to be_successful
      end
    end

    it "allow access to guests" do
      year = create(:album).year
      get albums_years_url
      expect(response).to be_successful
    end
  end

  describe "GET /albums/years/:id" do
    context "with an authenticated admin" do
      let(:authenticated_admin) { create(:user, :admin) }

      before do
        sign_in(authenticated_admin)
      end

      it "renders a successful response" do
        year = create(:album).year
        get albums_year_url(year)
        expect(response).to be_successful
      end
    end

    it "allows access to guests" do
      year = create(:album).year
      get albums_year_url(year)
      expect(response).to be_successful
    end
  end
end
