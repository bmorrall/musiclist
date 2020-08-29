source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'rockstart', github: 'bmorrall/rockstart'

  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'dotenv-rails', groups: [:development, :test]

gem 'lastfm'

gem 'lograge'
gem 'logstash-event'
gem 'rubocop-rails', require: false
gem 'factory_bot_rails', group: [:development, :test]
gem 'faker', group: [:development, :test]
gem 'rspec-rails', '~> 4.0.0', group: [:development, :test]
gem 'shoulda-matchers', group: :test

gem 'climate_control', group: :test
gem 'simplecov', group: :test
gem 'vcr', group: :test
gem 'webmock', group: :test

gem 'namae'
gem 'omniauth-auth0', '~> 2.2'
gem 'omniauth-rails_csrf_protection', '~> 0.1'
gem 'dalli'
gem 'connection_pool'
gem 'zero_downtime_migrations'
gem 'aws-sdk-s3', require: false
gem 'sidekiq'
gem 'pundit'
gem 'pundit-matchers', group: :test
gem 'simple_form'
gem 'title', github: 'calebthompson/title'
gem 'acts_as_list'
gem 'audited', '~> 4.9'
gem 'friendly_id'
gem 'kaminari'
gem 'rollbar', '~> 2.25.0'
gem 'okcomputer'
gem 'rubocop-rails', require: false, group: [:development, :test]
gem 'brakeman', group: [:development, :test]
gem 'bundler-audit', github: 'rubysec/bundler-audit', group: [:development, :test]
gem 'ip_anonymizer'
gem 'rack-attack'
gem 'capybara', '>= 2.15', group: :test

gem "stimulus_reflex", "~> 3.2"
