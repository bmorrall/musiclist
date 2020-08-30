# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy
# For further information see the following documentation
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy

# Configure any external domains used to host assets here
csp_connect_sources = []
csp_font_sources = []
csp_image_sources = []
csp_script_sources = []
csp_style_sources = []

# Allow the asset host to serve assets
if (asset_host = ENV["ASSET_HOST"].presence)
  csp_font_sources.append(asset_host)
  csp_image_sources.append(asset_host)
  csp_script_sources.append(asset_host)
  csp_style_sources.append(asset_host)
end

# Ensure secure websockets are used when requested
if (ENV["ALLOW_INSECURE_HTTP"].to_i != 1 && app_host = ENV["APP_HOST"].presence)
  csp_connect_sources += ["wss://#{app_host}"]
else
  csp_connect_sources += [:self]
end

# Allow webpacker to render styles inline
if Rails.env.development?
  csp_connect_sources += %w[http://localhost:3035 ws://localhost:3035]
  csp_style_sources.append(:unsafe_inline)
end

Rails.application.config.content_security_policy do |policy|
  policy.default_src :none
  policy.connect_src *csp_connect_sources
  policy.font_src    :self, *csp_font_sources
  policy.img_src     :self, :data, :https, *csp_image_sources
  policy.object_src  :none
  policy.script_src  :self, *csp_script_sources
  policy.style_src   :self, *csp_style_sources

  # Prevent non secure resources from being loaded
  policy.block_all_mixed_content
  policy.upgrade_insecure_requests

  # Specify URI for violation reports
  policy.report_uri "/csp_violations"
end

# If you are using UJS then enable automatic nonce generation
# Rails.application.config.content_security_policy_nonce_generator = -> request { SecureRandom.base64(16) }

# Set the nonce only to specific directives
# Rails.application.config.content_security_policy_nonce_directives = %w(script-src)

# Report CSP violations to a specified URI
# For further information see the following documentation:
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy-Report-Only
# Rails.application.config.content_security_policy_report_only = true
