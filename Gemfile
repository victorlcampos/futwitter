source 'https://rubygems.org'

gem "carrierwave"
gem "mini_magick"
gem 'nokogiri'

# UTILITIES
group :development do
  gem 'pry-rails'
  gem "better_errors"
  gem "binding_of_caller"

  # continuous integration
  gem 'guard-jasmine'
  gem "guard-rspec"
  gem 'guard-brakeman'
  gem 'guard-bundler'
  gem 'guard-livereload'
end

# QUALITY
# performance
gem 'dimensions-rails'

group :test, :development do
  # metrics
  gem 'simplecov', require: false
  gem 'simplecov-rcov-text', require: false
  gem 'metric_fu', '4.1.0'
  gem 'rubocop', '0.4.6'

  # security
  gem "brakeman", require: false

  # performance
  gem 'bullet'

  # test
  gem "rspec-rails"
  gem 'jasminerice'
end

group :test do
  # test
  gem 'shoulda-matchers'
  gem "factory_girl_rails"
  gem "capybara"

  # continuous integration
  gem 'rb-fsevent', require: false if RUBY_PLATFORM =~ /darwin/i
end

# CORE
gem 'rails', '3.2.13'
gem 'sqlite3'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'compass-rails'

  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'