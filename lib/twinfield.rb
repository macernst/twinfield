require "savon"
require "twinfield/config"
require "twinfield/session"
require "twinfield/process"
require "twinfield/finder"
require "twinfield/version"

module Twinfield
  WSDLS = {
    :session => "https://login.twinfield.com/webservices/session.asmx?wsdl",
    :process => "/webservices/processxml.asmx?wsdl"
    :finder => "/webservices/finder.asmx?wsdl"
  }
end