$:.unshift File.expand_path("../../lib", __FILE__)

require "rubygems"
require "twinfield"
require File.expand_path("../config", __FILE__)

# @session = Twinfield::Session.new

# # 1
# @session.logon
# @request = Twinfield::Request.new :session_id => @session.id
# @request.request
#
# # 2
# @session.request :process_xml_document do
#   "<xmlRequest><![CDATA[<list><type>offices</type></list>]]></xmlRequest>"
# end

# session = Twinfield::Session.new
# session_id = session.logon
#
# process = Twinfield::Process(session_id)
#
# process.request(method, &block)

# session = Twinfield::Session.new
# session.session_id
#
# Twinfield::Process.new(session.session_id).request do
#   "hallo"
# end