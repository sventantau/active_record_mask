#require 'rspec/rails'
require 'active_record'
require 'active_support/all'
require 'active_record_mask'

# Establish database connection
db_config = YAML.load_file(File.expand_path('support/database.yml', __dir__))['test']
ActiveRecord::Base.establish_connection(db_config)


# Load models and schema
require_relative 'support/models/some_class'
require_relative 'support/models/another_class'
require_relative 'support/models/more_class'


# Load schema to the test database
ActiveRecord::Schema.verbose = false
load(File.expand_path('support/schema.rb', __dir__))
