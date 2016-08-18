$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'boolean_timestamps'
require 'active_record'

# setup in-memory database
# see http://stackoverflow.com/questions/10605053/testing-activerecord-models-inside-a-gem
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, force: true do |t|
    t.datetime :activated_at
  end
end

RSpec.configure do |config|
  config.before do
    Time.zone = "America/New_York"
  end
end
