source 'https://rubygems.org'

ruby '2.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring', group: :development

gem 'sidekiq'
gem 'rugged'
gem 'github-linguist'
gem 'octokit'
gem 'lint_trap'
gem 'active_model_serializers', '~> 0.10.0.rc4'
gem 'stamped'
gem 'virtus'

gem 'pry-rails'
gem 'pry-byebug'
gem 'foreman'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

group :development, :test do
  gem 'rspec-rails'
  gem 'dotenv-rails'
end

group :test do
  gem 'rspec-its'
  gem 'factory_girl_rails'
  gem 'vcr'
  gem 'webmock'
  gem 'simplecov'
  gem 'json-schema'
end
