require "savon"
require "twinfield/config"
require "twinfield/session"
require "twinfield/version"

module Twinfield
  DOCUMENT_URLS = {
    :login => "https://login.twinfield.com/webservices/session.asmx?wsdl",
    :process => "https://c1.twinfield.com/webservices/processxml.asmx?wsdl",
    :find => "https://c1.twinfield.com/webservices/finder.asmx?wsdl"
  }.freeze
end