ENV['RAILS_ENV'] ||= 'test'

require 'support/factory_bot'
require 'support/application_spec_helper'

require File.expand_path('../../config/environment', __FILE__)
require 'spec_helper'
require 'rspec/rails'
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.render_views = true
  config.before(:each, type: :controller) do
    request.env['HTTP_ACCEPT'] = 'application/json' if defined? request
  end
end

