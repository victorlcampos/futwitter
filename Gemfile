source 'https://rubygems.org'

# IMAGES
gem "carrierwave"
gem "mini_magick"
gem 'dimensions-rails'

# PARSE
gem 'nokogiri'

# QUALITY
gem "rspec-rails", :group => [:test, :development]
group :test do
  gem 'shoulda-matchers'
  gem "factory_girl_rails"
  gem "capybara"

  gem "guard-rspec"
  gem 'rb-fsevent', require: false if RUBY_PLATFORM =~ /darwin/i

  gem 'simplecov'
  gem 'metric_fu'
end

# CORE
gem 'rails', '3.2.11'
gem 'sqlite3'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'