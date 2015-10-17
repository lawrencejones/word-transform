require 'rspec'
require_relative '../lib/word_transform'

RSpec.configure { |config| config.filter_run_excluding :benchmark }
