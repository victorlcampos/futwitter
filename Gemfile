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
gem 'dimensions-rails'
gem "rspec-rails", group: [:test, :development]
group :test do
  gem 'shoulda-matchers'
  gem "factory_girl_rails"
  gem "capybara"

  gem "guard-rspec"
  gem 'guard-brakeman'

  gem 'rb-fsevent', require: false if RUBY_PLATFORM =~ /darwin/i

  gem 'simplecov'
  gem 'metric_fu'
  gem "brakeman", require: false

  gem 'minitest'
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