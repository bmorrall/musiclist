# frozen_string_literal: true

require "vcr"

VCR.configure do |c|
  # Use rspec tags for vcr cassettes
  c.configure_rspec_metadata!

  c.cassette_library_dir = "spec/vcr"
  c.hook_into :webmock

  c.filter_sensitive_data("<LASTFM_API_KEY>") { ENV.fetch('LASTFM_API_KEY') }
  c.filter_sensitive_data("<LASTFM_API_SECRET>") { ENV.fetch('LASTFM_API_SECRET') }
end
