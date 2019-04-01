require 'active_record'

require_relative '../lib/database'
require_relative '../lib/models/user'
require_relative '../lib/models/message'
require_relative '../lib/models/message_user'

DBConnection.connect('test')
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:suite) do
    MessagesUsers.destroy_all
    Message.destroy_all
    User.destroy_all
  end
end
