source "http://rubygems.org"

# Sinatra microframework
gem "sinatra", "~> 1.2.6", require: "sinatra/base"

# JS Compression
gem "jsmin", "~> 1.0.0"

# Template engines
gem "haml", ">= 3.0"
gem "sass", "~> 3.1.1"

# Lots of nice stuff
gem "sinatra-content-for", require: "sinatra/content_for"
gem "sinatra-support", require: "sinatra/support"

# Sequel ORM migations
gem "sinatra-sequel", "~> 0.9.0", require: "sinatra/sequel"

# Support for V8/CoffeeScript on Heroku
gem "therubyracer-heroku", "0.8.1.pre3", require: false

# SQL ORM
gem "sequel", "~> 3.23.0"

# Better hashes (used for configs)
gem "hashie", "~> 1.0.0"

# User login
gem "shield", "~> 0.0.3"

# Internationalization
gem "i18n", "~> 0.5.0"

# Amazon S3 support
gem "aws-s3", "~> 0.6.2", require: "aws/s3"

group :development do
  gem "sqlite3", "~> 1.3.0"
end

group :test do
  # Test framework
  gem "test-unit", ">= 2.2.0", require: "test/unit"
  gem "test-unit-runner-failfast", require: "test/unit/runner/failfast"
  gem "contest"

  # RSpec-like syntax (two.should == 2)
  gem "renvy", ">= 0.2.0"

  # Acceptance tests
  gem "capybara"

  # Generates fake data (names, addresses, etc)
  gem "ffaker", "~> 1.4.0"

  # Forking tests
  gem "spork", "~> 0.8.4"
  gem "spork-testunit", "~> 0.0.5", require: false
end
