require File.expand_path('../../lib/twinfield', __FILE__)

def reset_config
  Twinfield.configure do |config|
    config.username = ""
    config.password = ""
    config.organisation = ""
  end
end

RSpec.configure do |config|
  config.before(:all) { reset_config }
end