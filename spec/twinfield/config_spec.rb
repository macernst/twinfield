require 'spec_helper'

describe Twinfield::Configuration do
  after do
    reset_config
  end

  it "configures username" do
    Twinfield.configure do |config|
      config.username = "my_username"
    end
    Twinfield.configuration.username.should == "my_username"
  end

  it "configures password" do
    Twinfield.configure do |config|
      config.password = "my_password"
    end
    Twinfield.configuration.password.should == "my_password"
  end

  it "configures organisation" do
    Twinfield.configure do |config|
      config.organisation = "my_organisation"
    end
    Twinfield.configuration.organisation.should == "my_organisation"
  end
end