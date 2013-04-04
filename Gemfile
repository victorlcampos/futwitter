source 'https://rubygems.org'

gem "carrierwave"
gem "mini_magick"
gem 'nokogiri'

# UTILITIES
group :development do
  gem 'pry-rails'
  gem "better_errors"
  gem "binding_of_caller"
end

# QUALITY
# PERFORMANCE
gem 'dimensions-rails'
gem 'bullet', group: [:test, :development]

# TEST
gem "rspec-rails", group: [:test, :development]
group :test do
  # TEST
  gem 'shoulda-matchers'
  gem "factory_girl_rails"
  gem "capybara"

  # SECURITY
  gem "brakeman", require: false

  # CONTINUOUS INTEGRATION
  gem "guard-rspec"
  gem 'guard-brakeman'
  gem 'rb-fsevent', require: false if RUBY_PLATFORM =~ /darwin/i

  # METRICS
  gem 'simplecov', require: false
  gem 'simplecov-rcov-text', require: false
  gem 'metric_fu', '4.1.0'
end

# CORE
gem 'rails', '3.2.13'
gem 'sqlite3'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'