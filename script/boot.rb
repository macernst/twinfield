$:.unshift File.expand_path("../../lib", __FILE__)

require "rubygems"
require "twinfield"
require File.expand_path("../config", __FILE__)
#
# @session = Twinfield::Session.new
# @session.logon
#
# @process = Twinfield::Process.new(@session.session_id, @session.cluster)