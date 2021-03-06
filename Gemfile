source 'https://rubygems.org'

gem 'carrierwave'
gem 'fog'
gem 'mini_magick'
gem 'nokogiri'
gem 'fastimage'

gem 'resque'
gem 'resque-scheduler', require: 'resque_scheduler'
gem "capistrano-resque", "~> 0.1.0"
gem 'daemons', '~> 1.1.9'
gem 'tweetstream'
gem 'unshortme'

gem 'capistrano'

# UTILITIES
group :development do
  gem 'pry-rails'
  gem 'better_errors'
  gem 'binding_of_caller'

  # continuous integration
  gem 'guard-rails'
  gem 'guard-jasmine'
  gem 'guard-rspec'
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
  gem 'brakeman', require: false

  # performance
  gem 'bullet'

  # test
  gem 'rspec-rails'
  gem 'jasminerice'
  gem "fakeweb", "~> 1.3"
end

group :test do
  # test
  gem 'shoulda-matchers'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'capybara'

  # continuous integration
  # gem 'rb-fsevent', require: false if RUBY_PLATFORM =~ /darwin/i
end

# CORE
gem 'rails', '3.2.13'
gem 'pg'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'compass-rails'

  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'