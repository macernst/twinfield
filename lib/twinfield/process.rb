module Twinfield
  class Process
    def initialize(session_id)
      @session_id = session_id
      @client = Savon::Client.new do
        wsdl.document = Twinfield::DOCUMENT_URLS[:process]
      end
    end

    def request(method, &block)
      client = Savon::Client.new do
        wsdl.document = "https://c1.twinfield.com/webservices/processxml.asmx?wsdl"
      end

      client.request :process_xml_document do
        soap.header = {
          "Header" => {
            "SessionID" => @session_id
          },
          :attributes! => {
            "Header" => {:xmlns => "http://www.twinfield.com/"}
          }
        }
        soap.body = block.call
      end
    end
  end
end