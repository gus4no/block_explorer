source "https://rubygems.org"

gem "rails", "~> 8.0.2"

gem "bootsnap", require: false
gem "brakeman", require: false
gem "capybara"
gem "debug", platforms: %i[mri windows], require: "debug/prelude"
gem "importmap-rails"
gem "jbuilder"
gem "kamal", require: false
gem "pg", "~> 1.1"
gem "propshaft"
gem "puma", ">= 5.0"
gem "rubocop-rails-omakase", require: false
gem "selenium-webdriver"
gem "solid_cache"
gem "solid_cable"
gem "solid_queue"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "thruster", require: false
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[windows jruby]
gem "web-console"

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

group :development, :test do
  gem "brakeman", require: false
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end
