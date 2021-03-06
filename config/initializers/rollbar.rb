# frozen_string_literal: true

Rollbar.configure do |config|
  # Without configuration, Rollbar is enabled in all environments.
  # To disable in specific environments, set config.enabled=false.

  config.access_token = ENV["ROLLBAR_ACCESS_TOKEN"]

  # Here we'll disable in 'test' and when not configured:
  config.enabled = false if Rails.env.test? || ENV["ROLLBAR_ACCESS_TOKEN"].blank?

  # By default, Rollbar will try to call the `current_user` controller method
  # to fetch the logged-in user object, and then call that object's `id`
  # method to fetch this property. To customize:
  # config.person_method = "my_current_user"
  config.person_id_method = "id"

  # Additionally, you may specify the following:
  config.person_username_method = "nickname"
  config.person_email_method = nil # do not send email address

  # If you want to attach custom data to all exception and message reports,
  # provide a lambda like the following. It should return a hash.
  # config.custom_data_method = lambda { {:some_key => "some_value" } }

  # Scrub userinfo from the session
  config.transform << proc do |options|
    data = options[:payload]['data']
    scrubbed_userinfo = Rollbar::Scrubbers.scrub_value(data[:request][:session][:userinfo])
    data[:request][:session][:userinfo] = scrubbed_userinfo
  end

  # Add exception class names to the exception_level_filters hash to
  # change the level that exception is reported at. Note that if an exception
  # has already been reported and logged the level will need to be changed
  # via the rollbar interface.
  # Valid levels: 'critical', 'error', 'warning', 'info', 'debug', 'ignore'
  # 'ignore' will cause the exception to not be reported at all.
  # config.exception_level_filters.merge!('MyCriticalException' => 'critical')
  #
  # You can also specify a callable, which will be called with the exception instance.
  # config.exception_level_filters.merge!('MyCriticalException' => lambda { |e| 'critical' })

  # Enable delayed reporting (using Sidekiq)
  config.use_sidekiq "queue" => "low"
  config.failover_handlers = [Rollbar::Delay::Thread]

  # If your application runs behind a proxy server, you can set proxy parameters here.
  # If https_proxy is set in your environment, that will be used. Settings here have precedence.
  # The :host key is mandatory and must include the URL scheme (e.g. 'http://'), all other fields
  # are optional.
  #
  # config.proxy = {
  #   host: 'http://some.proxy.server',
  #   port: 80,
  #   user: 'username_if_auth_required',
  #   password: 'password_if_auth_required'
  # }

  # Anonymize IP Addresses
  config.anonymize_user_ip = true

  # Send logger messages straight to Rollbar
  # require "rollbar/logger"
  # Rails.logger.extend(ActiveSupport::Logger.broadcast(Rollbar::Logger.new))

  # If you run your staging application instance in production environment then
  # you'll want to override the environment reported by `Rails.env` with an
  # environment variable like this: `ROLLBAR_ENV=staging`. This is a recommended
  # setup for Heroku. See:
  # https://devcenter.heroku.com/articles/deploying-to-a-custom-rails-environment
  config.environment = ENV["ROLLBAR_ENV"].presence || Rails.env
end
