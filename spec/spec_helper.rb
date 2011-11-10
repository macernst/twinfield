require File.expand_path('../../lib/twinfield', __FILE__)

def reset_config
  Twinfield.configure do |config|
    config.username = "NL000078"
    config.password = "yvy8116ume"
    config.organisation = "TWF-SAAS"
  end
end

RSpec.configure do |config|
  config.before(:all) { reset_config }
end