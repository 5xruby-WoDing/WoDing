# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.1'

gem 'devise', '~> 4.8'
gem 'paranoia', '~> 2.6'
gem 'rqrcode', '~> 2.1'
gem 'aasm', '~> 5.4'
gem 'aws-sdk-s3', require: false
gem 'redis', '~> 5.0'
gem 'ransack', '~> 3.2'
gem 'twsms2', '~> 1.3'
gem "rails-i18n", "~> 7.0"
gem "friendly_id", "~> 5.5"
gem "babosa", "~> 2.0"

gem 'rails', '~> 6.1.7'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rubocop-rails', '~> 2.17', require: false
  gem 'dotenv-rails'
  gem 'foreman', '~> 0.87.2'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'listen', '~> 3.3'
  gem 'spring', '~> 4.1'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]