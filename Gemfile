source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0'
gem 'rack-cors', :require => 'rack/cors'

#Jason Web Token 
gem 'jwt'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use mongoid for database
gem 'mongoid', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 1[pvafaf]
#Api gems
gem 'active_model_serializers'
gem 'devise'
gem 'random_images', '~> 0.0.6'
# Paginations
gem 'kaminari'
# Background job
gem 'sidekiq'
gem 'redis'
group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
group :development, :test do
  gem "factory_girl_rails"
  gem 'ffaker'
end

group :test do
  gem "shoulda-matchers"
  # gem 'mongoid-rspec'
  gem "rspec-rails", "~>2.14"
  gem 'mongoid-rspec'
end
