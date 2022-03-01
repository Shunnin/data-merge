# typed: ignore
require 'simplecov'
require 'simplecov-rcov'
require 'typhoeus'

SimpleCov.start 'rails' do
  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'
  add_group 'Presenters', 'app/presenters'
  add_group 'Services', 'app/services'
  add_group 'Utilities', 'app/utilities'
end

class SimpleCov::Formatter::RcovFormatter
  def write_file(template, output_filename, binding)
    rcov_result = template.result(binding)
    File.open(output_filename, "wb") do |file_result|
      file_result.write rcov_result
    end
  end
end

SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.before do
    Typhoeus::Expectation.clear
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
end
