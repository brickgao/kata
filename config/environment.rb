# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# Initialize Sentry
Raven.configure do |config|
  config.environments = ['staging', 'production']
end
