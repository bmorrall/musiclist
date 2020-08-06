# frozen_string_literal: true

namespace :heroku do
  ENV_VARIABLES = %w[
    AUTH0_CLIENT_ID
    AUTH0_CLIENT_SECRET
    AUTH0_DOMAIN
    CLOUDCUBE_ACCESS_KEY_ID
    CLOUDCUBE_SECRET_ACCESS_KEY
    CLOUDCUBE_URL
    ROLLBAR_ACCESS_TOKEN
  ].freeze

  def system!(*args)
    system(*args) || abort("\n== Command #{args} failed ==")
  end

  task :dump_config do
    system! "heroku config -s | grep '#{ENV_VARIABLES.join('\|')}' | tee -a .env"
  end
end
