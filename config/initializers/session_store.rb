# frozen_string_literal: true

# Use Cookies as the session store, and lock them down to the current domain
Rails.application.config.session_store :cookie_store, key: "_musiclist_session",
                                                      http_only: true,
                                                      same_site: :lax
