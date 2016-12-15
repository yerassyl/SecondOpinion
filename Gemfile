source 'https://rubygems.org'

ruby '2.3.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'coffee-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'
gem 'turbolinks', '~> 2.5', '>= 2.5.3'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'mailboxer' # Messaging gem

# major gems
gem 'react-rails', '~> 1.6.1' # react js library
gem 'foundation-rails', '~> 5.5', '>= 5.5.3.2' # foundation zurb for front-end
gem 'font-awesome-rails' # icons
gem 'active_model_serializers' # json serializers

gem 'rails_admin', '~> 1.0'
gem 'devise' # authorization library
gem 'cancancan', '~> 1.10'  # authentication library
gem 'carrierwave' # file upload
gem 'remotipart', '~> 1.3' # file upload via js

# small functionality gems
gem 'country_select' # select tag with all countries in iso etc. formats
gem 'kaminari' # pagintaion library
gem 'cocoon' # allows easier nested attributes
gem 'select2-rails' # select2 plugin


gem 'filterrific' # for filters
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

gem 'paperclip', '~> 5.0.0'

gem 'pg'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :developmentrai
group :production do
  gem 'rails_12factor'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'cucumber-rails', :require => false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
  gem 'rspec-rails', '~> 3.0'
  gem 'faker' # only for testing
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

end

