source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0.rc1', '< 5.1'
gem 'dotenv-rails', require: 'dotenv/rails-now', groups: [:development, :test]
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'rack-cors'
gem 'active_model_serializers'
gem 'devise'
gem 'jwt'
gem 'koala', '~> 2.2'

group :development, :test do
  # For environment variables
  gem 'byebug', platform: :mri
  gem 'faker'
end

group :development do
  gem 'annotate'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'guard'
  gem 'rubocop'
  gem 'guard-annotate'
  gem 'guard-rubocop', require: false
  gem 'guard-bundler', require: false
  gem 'guard-minitest', require: false
end

group :test do
  gem 'minitest-spec-rails'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
# For image upload
gem 'carrierwave'
# For upload image on cloud
gem 'cloudinary'
# For upload base64 image
gem 'carrierwave-base64'
