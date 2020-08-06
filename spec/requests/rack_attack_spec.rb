# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Rack::Attack", type: :request do
  describe "req/ip throttle" do
    it "rate limits requests from spammy clients" do
      300.times do
        get root_url
        expect(response).not_to have_http_status(:too_many_requests)
      end

      get root_url
      expect(response).to have_http_status(:too_many_requests)
    end
  end

  describe "fail2ban/pentesters blocklist" do
    PENTESTING_PATHS = %w[
      /etc/passwd
      /bad_endpoint?secret_file=/etc/passwd
      /wp-admin
      /wp-login
      /example.php
    ].freeze

    DENIAL_URL = "https://www.youtube.com/watch?v=dQw4w9WgXcQ"

    PENTESTING_PATHS.each do |pentesting_path|
      it "blocks clients after repeat visits to #{pentesting_path}" do
        2.times do
          get pentesting_path
          expect(response).to have_http_status(:moved_permanently)
          expect(response).to redirect_to(root_url)
        end

        get root_url
        expect(response).not_to redirect_to(DENIAL_URL)

        get pentesting_path
        expect(response).to have_http_status(:moved_permanently)
        expect(response).to redirect_to(root_url)

        get root_url
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(DENIAL_URL)
      end
    end

    PENTESTING_PATHS.shuffle.combination(3).to_a.sample.tap do |url_a, url_b, url_c|
      it "shares the visit count between pentesting routes (e.g. #{url_a}, #{url_b}, #{url_c})" do
        get url_a
        get url_b
        get url_c

        get root_url
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(DENIAL_URL)
      end
    end
  end
end
