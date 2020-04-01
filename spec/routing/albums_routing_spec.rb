# frozen_string_literal: true

require "rails_helper"

RSpec.describe AlbumsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/").to route_to("albums#index")
      expect(get: "/albums").to route_to("albums#index")
    end
  end
end
