# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/albums", type: :request do
  describe "GET /" do
    it "renders a successful response" do
      create(:album)
      get root_url
      expect(response).to be_successful
    end
  end

  describe "GET /albums" do
    it "renders a successful response" do
      create(:album)
      get albums_url
      expect(response).to be_successful
    end
  end

  describe "GET /albums AS JSON" do
    it "renders a successful response" do
      create(:album)
      get albums_url(format: :json)
      expect(response).to be_successful
    end
  end
end
